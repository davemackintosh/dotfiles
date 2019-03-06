#!/bin/env bash

pip install neovim &&
npm i -G neovim &&
[[ ! -d ~/.vim/bundle/Vundle.vim ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
cp ../.ctags "$HOME/" &&
cp ../.vimrc "$HOME/" &&
mkdir -p "$HOME/.config" &&
cp -R .config/nvim "$HOME/.config" &&
nvim +UpdateRemotePlugins +qall &&
nvim +PluginClean! +qall &&
nvim +PluginInstall +qall 

