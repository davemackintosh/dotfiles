#!/bin/env zsh

set -e

git submodule update --init --recursive --remote &
wait $!

mkdir -p "$HOME/.config"

ln -sf ~/dotfiles/shared/.zshrc $HOME/
ln -sf ~/dotfiles/shared/paths.zsh $HOME/
ln -sf ~/dotfiles/shared/aliases.zsh $HOME/
ln -sf ~/dotfiles/shared/keybindings.zsh $HOME/
ln -sf ~/dotfiles/shared/.p10k.zsh $HOME/
ln -sf ~/dotfiles/shared/.tmux.conf $HOME/
ln -sf ~/dotfiles/shared/.gitconfig $HOME/
ln -sf ~/dotfiles/kitty.conf $HOME/.config/kitty/kitty.conf
