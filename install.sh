#!/bin/env bash

echo "Running install for $OS"

if [[ "$ANDROID_ROOT" = "/system" ]]; then
  wget https://git.io/oh-my-termux -O - | bash &&
  ./android.sh
#elif [[ "$OS" = "Linux" ]]; then
#  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
#  ./linux.sh
fi

