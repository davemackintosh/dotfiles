#!/bin/env bash

export EDITOR=nvim

################################################################################
# Aliases
################################################################################
# CD-ing backwards.
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'

# Fix reset command
alias reset='echo -e "\e[3J" && reset'

# Git aliases
alias gs='git status'
alias gp='git push'
alias gc='git commit -m'
alias gca='git commit -a -v'
alias ga='git add'
alias gaa='git add -A'
alias gir='echo "GRRRRR TYPOS 🤓" && git'

# Other aliases
alias da='direnv allow'
alias dclf='docker-compose logs -f'

# Go aliases
alias gtc='go test -cover -race'
alias gv='go vet ./...'
alias glci='golangci-lint run --fix -c .golangci.json'

function killPort {
 kill -9 $(lsof -i TCP:$1 | grep LISTEN | awk '{print $2}')
}

alias python="python3"
