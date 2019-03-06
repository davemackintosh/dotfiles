#!/bin/env bash

termux-setup-storage &&
./tasks/apt.sh &&
./tasks/zsh.sh &&
sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)" &&
./tasks/npm.sh &&
./tasks/nvim.sh &&
./tasks/ssh.sh

