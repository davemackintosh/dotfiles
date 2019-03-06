#!/bin/env bash

wget -O "$HOME/z.sh" https://raw.githubusercontent.com/rupa/z/master/z.sh &&
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k || true &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting || true &&
cp .zshrc "$HOME/.zshrc"
