# ZSH config.
export ZSH="/home/dave/.oh-my-zsh"
ZSH_THEME="powerlevel9k/powerlevel9k"
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
plugins=(git zsh-syntax-highlighting)
. $ZSH/oh-my-zsh.sh

# Editor config
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Tools
. ~/z.sh
. ./aliases.sh

