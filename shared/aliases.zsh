#!/bin/env bash

EDITOR=nvim

# Aliases
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'
alias reset='echo -e "\e[3J" && reset'
alias gs='git status'
alias gp='git push'
alias gc='git commit -m'
alias gca='git commit -a -v'
alias ga='git add'
alias gaa='git add -A'
alias gir='echo "GRRRRR TYPOS 🤓" && git'

alias da='direnv allow'
alias dclf='docker-compose logs -f' 

function killPort {
 kill -9 $(lsof -i TCP:$1 | grep LISTEN | awk '{print $2}')
}

alias python="python3"
