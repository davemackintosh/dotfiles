#!/bin/env bash

apt install -y make git &&

git clone git@github.com:davemackintosh/dotfiles.git "$HOME/dotfiles" &&

make

