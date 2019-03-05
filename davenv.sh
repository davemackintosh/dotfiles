#!/bin/env bash

apt install -y make git openssl &&

git clone git@github.com:davemackintosh/dotfiles.git "$HOME/dotfiles" &&

make

