#!/bin/env bash

echo "Running install for $OS"

if [[ "$ANDROID_ROOT" = "/system"  ]]; then
  ./android.sh
elif [[ "$OS" = "Linux" ]]; then
  ./linux.sh
fi

