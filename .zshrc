# ZSH config.
export ZSH="/home/dave/.oh-my-zsh"
ZSH_THEME="powerlevel9k/powerlevel9k"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
plugins=(git)
. $ZSH/oh-my-zsh.sh

# Editor config
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Tools
. ~/z.sh

# Aliases
alias ..='cd ../'
alias ...='cd ../../'
alias ....='cd ../../../'
alias reset='echo -e "\e[3J" && reset'
alias gs='git status'
alias gp='git push'
alias gc='git commit -m'
alias ga='git add'
alias gaa='git add -A'

. $HOME/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

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
