#!/bin/env bash

echo "Running install for $OS"

if [[ "$ANDROID_ROOT" = "/system"  ]]; then
  git clone https://github.com/adi1090x/termux-omz.git || true &&
  chmod +x termux-omz/setup &&
  ./termux-omz/setup &&
  ./android.sh
elif [[ "$OS" = "Linux" ]]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
  ./linux.sh
fi

