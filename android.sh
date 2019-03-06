#!/bin/env bash

termux-setup-storage &&
./tasks/apt.sh &&
./tasks/zsh.sh &&
./tasks/npm.sh &&
./tasks/nvim.sh &&
source ".zshrc" &&
./tasks/ssh.sh

