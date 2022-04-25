#!/bin/env zsh

mkdir -p $HOME/.config
ln -sf `pwd`/nvim $HOME/.config/nvim
ln -sf `pwd`/ranger $HOME/.config/ranger
ln -sf `pwd`/shared/.zshrc $HOME/
ln -sf `pwd`/shared/paths.zsh $HOME/
ln -sf `pwd`/shared/aliases.zsh $HOME/
ln -sf `pwd`/shared/keybindings.zsh $HOME/
ln -sf `pwd`/shared/.p10k.zsh $HOME/
ln -sf `pwd`/shared/.tmux.conf $HOME/
ln -sf `pwd`/shared/.gitconfig $HOME/
