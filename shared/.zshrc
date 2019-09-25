# ZSH config.
export LANG="en_GB.UTF-8"
export TERM=screen-256color
export ZSH="$HOME/.oh-my-zsh"

if [ "$ANDROID_ROOT" = "/system" ]; then
  source $HOME/.oh-my-zsh/custom/themes/powerlevel9k/powerlevel9k.zsh-theme
else
  source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
fi
ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs_joined)
if [ "$ANDROID_ROOT" = "/system" ]; then
else
  plugins=(git safe-paste)
fi

source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ "$ANDROID_ROOT" = "/system" ]; then
  source $HOME/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
else
  source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Tools
. $ZSH/oh-my-zsh.sh
. ~/z.sh
. ./aliases.sh

# Editor config
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fd --type f'

# Export NVM program.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

if hash tmux 2>/dev/null; then
  tmux
fi
neofetch

