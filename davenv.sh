#!/bin/env bash

apt install -y make git openssh &&

git clone https://github.com/davemackintosh/dotfiles.git "$HOME/dotfiles" &&

cd "$HOME/dotfiles" && 
bash ./install.sh

