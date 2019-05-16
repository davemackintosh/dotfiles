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
  .config/compton
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

echo "Generating new deps lists\n"

echo "Generating pacman deps list\n"
comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel | sort) > $HOME/dotfiles/deps.txt &&
echo "Generating yaourt deps list\n"
yaourt -Qm > dotfiles/yaourt-deps.txt &&
