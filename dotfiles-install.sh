#!/usr/bin/env bash

R="\e[31m"
G="\e[32m"
B="\e[34m"
C="\e[0m"

function backupExisting {
  if [ -e "$1" ]; then
    echo -e "Backing up\n  ${B}$1${C}\nto\n  ${G}$1-YOURS${C}"

    mv "$1" "$1-YOURS"
  fi
}

function installFile {
  backupExisting "$2" &&
  echo -e "\n-v"

  echo -e "Installing\n  ${B}$1${C}\nto\n  ${G}$2${C}"
  ln -s "$1" "$2"
  echo -e "\n-----------"
}

declare -A FILES
FILES["$PWD/shared/.gitconfig"]="$HOME/.gitconfig"
FILES["$PWD/shared/.zshrc"]="$HOME/.zshrc"
FILES["$PWD/shared/aliases.sh"]="$HOME/aliases.sh"
FILES["$PWD/shared/z.sh"]="$HOME/z.sh"
FILES["$PWD/.config/nvim"]="$HOME/.config/nvim"
FILES["$PWD/arch/.tmux.conf"]="$HOME/.tmux.conf"
FILES["$PWD/.config/ranger"]="$HOME/.config/ranger"

if [ $1 = "x86" ]; then
  FILES["$PWD/.config/awesome"]="$HOME/.config/awesome"
  FILES["$PWD/.config/compton"]="$HOME/.config/compton"
  FILES["$PWD/.config/rofi"]="$HOME/.config/rofi"
  FILES["$PWD/.config/termite"]="$HOME/.config/termite"
fi

if [ $1 = "android" ]; then
  FILES["$PWD/android/.termux"]="$HOME/.termux"
fi

for src in "${!FILES[@]}"
do
  installFile "$src" "${FILES[$src]}"
done

unset FILES
echo -e "I strongly suggest you restart your computer now."
