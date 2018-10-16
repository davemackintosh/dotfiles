#!/bin/bash

termux-setup-storage &&
apt install git curl wget nodejs python vim &&
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
wget -O $HOME/.vimrc https://gist.githubusercontent.com/davemackintosh/91c79f040c6c7902366ea8a101d4d646/raw/b0c159e307ce57ce8d570d23da454e099b67d093/.vimrc &&
npm i -g flow-bin eslint flow-node &&
vim +PluginInstall +qall