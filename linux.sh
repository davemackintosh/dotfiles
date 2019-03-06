#!/bin/env bash

./tasks/apt.sh &&
./tasks/zsh.sh &&
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
./tasks/npm.sh &&
./tasks/nvim.sh &&
./tasks/ssh.sh

