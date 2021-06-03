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
alias gir='echo "GRRRRR TYPOS 🤓" && git'

if [[ $OS = "Android" ]]; then
  alias chcolor="$HOME/.termux/colors.sh"
  alias chfont="$HOME/.termux/fonts.sh"
  alias startPostgres='pg_ctl -D $PREFIX/var/lib/postgresql start'
  alias stopPostgres='pg_ctl -D $PREFIX/var/lib/postgresql stop'
fi

alias set-java='sudo alternatives --config java;export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::");source  ~/.zshrc'

if [[ $OS = "Linux" ]]; then
  export NVM_DIR="$HOME/.nvm"
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

  # Project specific aliases
  alias rbs='reset && bin/server'
  alias dclf='docker-compose logs -f' 
  alias ff='firefox'
  alias chrome='google-chrome-stable'

  eval $(thefuck --alias)
fi

killPort() {
	lsof -i TCP:$1 | grep LISTEN | awk '{print $2}'
}
