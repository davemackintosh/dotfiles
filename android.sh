#!/bin/env bash

termux-setup-storage &&
./tasks/apt.sh &&
./tasks/zsh.sh &&
./tasks/npm.sh &&
./tasks/nvim.sh &&
source "$HOME/.zshrc" &&
./tasks/ssh.sh

