#!/bin/env bash

pip install neovim &&
npm i -G neovim &&
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim || true &&
cp .ctags "$HOME/" || true &&
cp .vimrc "$HOME/" || true &&
mkdir -p "$HOME/.config" &&
cp -R .config/nvim "$HOME/.config" &&
nvim +PluginInstall +qall &&
nvim +UpdateRemotePlugins +qall

