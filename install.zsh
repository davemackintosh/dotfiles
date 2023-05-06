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

mkdir -p ~/.tmux/plugins
if [ ! -d ~/.tmux/plugins/nord-tmux ]; then
	await git clone https://github.com/arcticicestudio/nord-tmux.git ~/.tmux/plugins/nord-tmux
else
	await git -C ~/.tmux/plugins/nord-tmux pull
fi

# Install some configs that live at $HOME
ln -sf ~/dotfiles/.zshrc $HOME/
ln -sf ~/dotfiles/.gitconfig $HOME/
ln -sf ~/dotfiles/.tmux.conf $HOME/
ln -sf ~/dotfiles/.gitmessage $HOME/
ln -sf ~/dotfiles/kitty $HOME/.config/
ln -sf ~/dotfiles/hypr $HOME/.config/
ln -sf ~/dotfiles/swaylock $HOME/.config/
ln -sf ~/dotfiles/waybar $HOME/.config/
ln -sf ~/dotfiles/wofi $HOME/.config/
ln -sf ~/dotfiles/dunst $HOME/.config/
ln -sf ~/dotfiles/waycorner $HOME/.config/
ln -sf ~/dotfiles/wlogout $HOME/.config/
ln -sf ~/dotfiles/ranger $HOME/.config/

# Install goenv.
if [ ! -d ~/.goenv ]; then
	await git clone https://github.com/syndbg/goenv.git ~/.goenv
fi
await goenv install 1.20.2 &
await goenv global 1.20.2 &
await pip install -r ./requirements.txt

# Install nodejs.
await curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.2/install.sh | bash
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
await nvm install 16

# Install starship.
await curl -sS https://starship.rs/install.sh | sh
