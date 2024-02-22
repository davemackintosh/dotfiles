#!/usr/bin/env zsh

set -e

# Wait for a command to finish and exit as if it wasn't a subshell on error.
function await {
	$@ &
	local pid=$!
	wait $pid

	if [ $? -ne 0 ]; then
		echo "Failed to execute $@"
		exit $?
	fi
}

# Pull our dependencies.
await git submodule update --init --recursive --remote

# Download Znap, if it's not there yet.
[[ -r $HOME/dotfiles/Repos/znap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git $HOME/dotfiles/Repos/znap
znap source marlonrichert/zsh-autocomplete
source $HOME/dotfiles/Repos/znap/znap.zsh  # Start Znap

# Install some configs.
ln -sf $HOME/dotfiles/fish $HOME/.config/
ln -sf $HOME/dotfiles/.zshrc $HOME/
ln -sf $HOME/dotfiles/.gitconfig $HOME/
ln -sf $HOME/dotfiles/.tmux.conf $HOME/
ln -sf $HOME/dotfiles/.gitmessage $HOME/
mkdir -p $HOME/.config/efm-langserver/
ln -sf $HOME/dotfiles/efm-langserver/.config.yaml $HOME/.config/efm-langserver/
ln -sf $HOME/dotfiles/starship.toml $HOME/.config/

if ! test -d $HOME/.pyenv/; then
	await curl https://pyenv.run | bash
fi

# If it's not Termux.
if test -z "$TERMUX_VERSION"; then
	# Install goenv, termux doesn't support this.
	if [ ! -d ~/.goenv ]; then
		await git clone https://github.com/syndbg/goenv.git $HOME/.goenv
	fi
	await goenv install 1.21.3
	await goenv global 1.21.3

	# install terminal config.
	ln -sf ~/dotfiles/kitty $HOME/.config/

	# Install Starship
	await curl -sS https://starship.rs/install.sh | sh
else
	await pkg i -y getconf

	# install terminal config.
	ln -sf ~/dotfiles/.termux $HOME/
	cp "./patched-fonts/CozetteVector Nerd Font Complete Mono.ttf" $HOME/.termux/font.ttf

	# Install starship (note the specifics for termux here.)
	await curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir /data/data/com.termux/files/usr/bin
fi

# Install Nvim dotfiles.
if test -z "$NO_NVIM"; then
	if ! test -d "$HOME/.config/nvim"; then
		if test -f "$HOME/.ssh/id_ecdsa.pub"; then
			await git clone git@github.com:davemackintosh/nvim $HOME/.config/nvim
		else
			echo -e "WARN: No SSH key so cloning read only nvim config"
			await git clone https://github.com/davemackintosh/nvim $HOME/.config/nvim
		fi
	fi


	if ! test -z "$TERMUX_VERSION"; then
		pkg i neovim fzf fd ripgrep nodejs go rust clang
		$HOME/.config/nvim/collateral/dependencies
	fi
fi
