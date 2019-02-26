#!/bin/env bash


# Aliases
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias reset='echo -e "\e[3J" && reset'
alias gs='git status'
alias gp='git push'
alias gc='git commit -m'
alias gca='git commit -a -v'
alias ga='git add'
alias gaa='git add -A'

if [[ $OS = "Android" ]]; then
  alias chcolor="$HOME/.termux/colors.sh"
  alias chfont="$HOME/.termux/fonts.sh"
fi

if [[ $OS = "Linux" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

  # Project specific aliases
  alias rbs='reset && bin/server'
  alias dclf='docker-compose logs -f'

  eval $(thefuck --alias)
fi
