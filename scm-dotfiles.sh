#!/bin/zsh

setopt EXTENDED_GLOB

declare -a files=(
  .gitconfig
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
  .config/rofi
  .config/mpd
  z.sh
  aliases.sh
)

for fileOrFolder in ${files[@]}; do
  echo "Copying $fileOrFolder"
  if [[ -d $fileOrFolder ]]; then
    mkdir -p $HOME/dotfiles/$fileOrFolder/ &&
      cp -R $fileOrFolder/^(.git|plugins|lain|bundle) $HOME/dotfiles/$fileOrFolder/
  else
    cp $fileOrFolder $HOME/dotfiles/$fileOrFolder
  fi
done

echo "Generating new deps lists\n"

echo "Generating pacman deps list"
comm -23 <(pacman -Qeq | sort) <(pacman -Qgq base base-devel | sort) > $HOME/dotfiles/deps.txt &&
echo "Generating yaourt deps list"
yaourt -Qm > dotfiles/yaourt-deps.txt &&

cd dotfiles
