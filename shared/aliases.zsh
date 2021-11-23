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

alias dclf='docker-compose logs -f' 

if [[ $OS = "Android" ]]; then
  alias chcolor="$HOME/.termux/colors.sh"
  alias chfont="$HOME/.termux/fonts.sh"
  alias startPostgres='pg_ctl -D $PREFIX/var/lib/postgresql start'
  alias stopPostgres='pg_ctl -D $PREFIX/var/lib/postgresql stop'
fi

alias set-java='sudo alternatives --config java;export JAVA_HOME=$(readlink -f /usr/bin/java | sed "s:bin/java::");source  ~/.zshrc'

killPort() {
 kill -9 $(lsof -i TCP:$1 | grep LISTEN | awk '{print $2}')
}

alias j17="export JAVA_HOME=$(/usr/libexec/java_home -v 17); java -version"
alias j11="export JAVA_HOME=`/usr/libexec/java_home -v 11`; java -version"
alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
