#!/bin/env bash

termux-setup-storage &&
./tasks/apt.sh &&
./tasks/zsh.sh &&
./tasks/npm.sh &&
./tasks/nvim.sh &&
./tasks/ssh.sh &&
echo -e "\nPlease restart Termux, installation has completed" &&
logout
