#!/bin/bash

termux-setup-storage &&
apt update &&
apt install ctags zsh openssh git clang curl wget nodejs python python2 python-dev neovim &&
pip install neovim &&
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
[[ ! -d ~/.vim/bundle/Vundle.vim ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
npm i -g flow-bin eslint flow-node yarn &&
mkdir -p $HOME/.config/nvim &&
mv .config-nvim-init.vim $HOME/.config/nvim/init.vim &&
[[ -f $HOME/.vimrc ]] && mv $HOME/.vimrc $HOME/.vimrc-yours &&
nvim +PluginClean! +qall &&
nvim +PluginInstall +qall