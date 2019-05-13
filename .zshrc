# ZSH config.
export ZSH="$HOME/.oh-my-zsh"

source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
plugins=(git zsh-syntax-highlighting)

# Tools
. $ZSH/oh-my-zsh.sh
. ~/z.sh
. ./aliases.sh

# Editor config
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi


