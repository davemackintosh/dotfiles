#!/bin/env zsh

set -e

git submodule update --init --recursive --remote &
wait $!

ln -sf ~/dotfiles/shared/.zshrc $HOME/
ln -sf ~/dotfiles/shared/paths.zsh $HOME/
ln -sf ~/dotfiles/shared/aliases.zsh $HOME/
ln -sf ~/dotfiles/shared/keybindings.zsh $HOME/
ln -sf ~/dotfiles/shared/.p10k.zsh $HOME/
ln -sf ~/dotfiles/shared/.tmux.conf $HOME/
ln -sf ~/dotfiles/shared/.gitconfig $HOME/

# Ask the user for their Github username
read -p "Enter your Github username: " github_username
git config --global user.name "$github_username"

# Ask the user for their Github email
read -p "Enter your Github email: " github_email
git config --global user.email "$github_email"
