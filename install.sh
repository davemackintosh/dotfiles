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

if test -f "$HOME/.ssh/id_ecdsa.pub"
	await git clone git@github.com:davemackintosh/nvim $HOME/.config/nvim
else
	echo -e "WARN: No SSH key so cloning read only nvim config"
	await git clone https://github.com/davemackintosh/nvim $HOME/.config/nvim
end

# Install some configs.
ln -sf ~/dotfiles/fish $HOME/.config/
ln -sf ~/dotfiles/.gitconfig $HOME/
ln -sf ~/dotfiles/.tmux.conf $HOME/
ln -sf ~/dotfiles/.gitmessage $HOME/
ln -sf ~/dotfiles/efm-langserver $HOME/.config/

await curl https://pyenv.run | bash

# If it's not Termux.
if test -z "$TERMUX_VERSION"
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
end

# Install Nvim dotfiles.
if test -z "$NO_NVIM"
	if test -f $HOME/.ssh/id_ed25519
		git clone git@github.com:davemackintosh/nvim $HOME/.config/nvim
	else
		git clone https://github.com/davemackintosh/nvim $HOME/.config/nvim
	end


	if ! test -z "$TERMUX_VERSION"
		pkg i neovim fzf fd ripgrep nodejs go rust clang
		$HOME/.config/nvim/collateral/dependencies
	end
end
