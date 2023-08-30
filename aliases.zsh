#!/bin/env bash

alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias .......='cd ../../../../../../'

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -lA'
alias l='ls -CF'

# Git aliases
alias gs='git status'
alias gd='git diff'
alias gp='git push'
alias gc='git commit -m'
alias ga='git add'
alias gl='git pull'
alias gaa='git add -A'
alias gco='git checkout'
alias gir='echo "GRRRRR TYPOS 🤓" && git'

# Other aliases
alias da='direnv allow'

# Go aliases
alias gmt='go mod tidy'
alias gtc='go test -cover -race'
alias gv='go vet'
alias glci='golangci-lint run --fix -c .golangci.json'
alias gocov='go test -coverprofile=coverage.out ./... && go tool cover -html=coverage.out'

alias updatekitty='curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin'

function gitMergeLatestRemote {
	git fetch origin $1:$1 && git merge $1
}
