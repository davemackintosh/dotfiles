#!/usr/bin/env zsh

set -e

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

if [[ -f "$HOME/.ssh/id_ecdsa.pub" ]]; then
	await git clone git@github.com:davemackintosh/nvim $HOME/.config/nvim
else
	echo -e "WARN: No SSH key so cloning read only nvim config"
	await git clone https://github.com/davemackintosh/nvim $HOME/.config/nvim
fi

mkdir -p $HOME/.tmux/plugins
if [ ! -d $HOME/.tmux/plugins/nord-tmux ]; then
	await git clone https://github.com/arcticicestudio/nord-tmux.git $HOME/.tmux/plugins/nord-tmux
else
	await git -C $HOME/.tmux/plugins/nord-tmux pull
fi

# Install some configs that live at $HOME
ln -sf ~/dotfiles/.zshrc $HOME/
ln -sf ~/dotfiles/.gitconfig $HOME/
ln -sf ~/dotfiles/.tmux.conf $HOME/
ln -sf ~/dotfiles/.gitmessage $HOME/
ln -sf ~/dotfiles/efm-langserver $HOME/.config/

# Install goenv.
if [ ! -d ~/.goenv ]; then
	await git clone https://github.com/syndbg/goenv.git $HOME/.goenv
fi
await goenv install 1.21.3
await goenv global 1.21.3

# If it's not Termux.
if [[ -z "${TERMUX_VERSION}" ]]; then
	ln -sf ~/dotfiles/kitty $HOME/.config/
	await curl -sS https://starship.rs/install.sh | sh
else
	await pkg i -y getconf
	ln -sf ~/dotfiles/.termux $HOME/
	cp "./patched-fonts/CozetteVector Nerd Font Complete Mono.ttf" $HOME/.termux/font.ttf
	await curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir /data/data/com.termux/files/usr/bin
fi

# Install Nvim dotfiles.
if [[ -z "$NO_NVIM" ]]; then
	if [[ -f $HOME/.ssh/id_ed25519 ]]; then
		git clone git@github.com:davemackintosh/nvim $HOME/.config/nvim
	else
		git clone https://github.com/davemackintosh/nvim $HOME/.config/nvim
	fi


	if [[ ! -z "${TERMUX_VERSION}" ]]; then
		pkg i neovim
		$HOME/.config/nvim/collateral/dependencies
	fi
fi
