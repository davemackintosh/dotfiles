# ZSH config.
export LANG=en_GB.UTF-8
export ZSH="$HOME/.oh-my-zsh"
export MOZ_USE_XINPUT2 DEFAULT=1
export GDK_DPI_SCALE=2

# git clone https://github.com/dracula/zsh.git ~/.oh-my-zsh/themes/dracula
#. ~/.oh-my-zsh/themes/dracula/dracula.zsh-theme

if [ "$ANDROID_ROOT" = "/system" ]; then
  source $HOME/.oh-my-zsh/custom/themes/powerlevel9k/powerlevel9k.zsh-theme
else
  export LC_ALL=en_GB.UTF-8  
  source /usr/share/zsh-theme-powerlevel9k/powerlevel9k.zsh-theme
fi

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir vcs)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status background_jobs_joined)
plugins=(git safe-paste tmux)

# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ "$ANDROID_ROOT" = "/system" ]; then
  ANDROID_NDK="$HOME/android-ndk-r17"
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

# Paths.
export ANDROID_HOME="$HOME/Android/Sdk"
export PATH="$PATH:/opt/android-sdk/build-tools/29.0.2"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# Export NVM program.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# Start typing and use arrows to search history.
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# We can't specify start up args to Termux
# so if we're on Android. Run TMux.
if [ "$ANDROID_ROOT" = "/system" ]; then
  tmux -u
else
  pfetch
fi

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$ANDROID_NDK:$PATH"
