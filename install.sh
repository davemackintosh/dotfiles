#!/bin/env bash

echo "Running install for $OS"

if [[ "$OS" = "Android"  ]]; then
  ./android.sh
elif [[ "$OS" = "Linux" ]]; then
  ./linux.sh
fi

