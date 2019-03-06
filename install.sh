#!/bin/env bash
	
if [[ "$OS" = "Android"  ]]; then
  ./android.sh
elif [[ "$OS" = "Linux" ]]; then
  ./linux.sh
fi

