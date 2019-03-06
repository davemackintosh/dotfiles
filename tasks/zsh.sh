#!/bin/env bash

wget -O "$HOME/z.sh" https://raw.githubusercontent.com/rupa/z/master/z.sh &&
[[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]] && git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&
cp .zshrc "$HOME/.zshrc"
