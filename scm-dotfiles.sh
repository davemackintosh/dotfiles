#!/bin/zsh

setopt EXTENDED_GLOB

declare -a files=(
  .gitconfig
  .vimrc
  .xbindkeysrc
  .Xdefaults
  .xinitrc
  .xserverrc
  .xsession
  .zshrc
  .config/awesome
  .config/neofetch
  .config/nvim
  .config/ranger
  z.sh
  aliases.sh
)

for fileOrFolder in ${files[@]}; do
  echo "Copying $fileOrFolder"
  if [[ -d $fileOrFolder ]]; then
    mkdir -p $HOME/dotfiles/$fileOrFolder/ &&
      cp -R $fileOrFolder/^(.git|plugins|lain) $HOME/dotfiles/$fileOrFolder/
  else
    cp $fileOrFolder $HOME/dotfiles/$fileOrFolder
  fi
done
