#!/bin/env bash

echo "Running install for $OS"

if [[ "$ANDROID_ROOT" = "/system"  ]]; then
  sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)" &&
  ./android.sh
elif [[ "$OS" = "Linux" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
  ./linux.sh
fi

