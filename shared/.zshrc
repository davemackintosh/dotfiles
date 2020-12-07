# ZSH config.
if [[ $OS = "" ]]; then
export OS=$(uname -s)
fi
export LANG=en_GB.UTF-8
export ZSH="$HOME/.oh-my-zsh"
export GDK_DPI_SCALE=1

source /usr/share/powerline/zsh/powerline.zsh

ENABLE_CORRECTION="true"
COMPLETION_WAITING_DOTS="true"
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(dir newline vcs )
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(background_jobs_joined)
plugins=(git firewalld safe-paste tmux zsh-syntax-highlighting zsh-autosuggestions)

# Tools
. $ZSH/oh-my-zsh.sh
. $HOME/z.sh
. $HOME/aliases.sh

# Editor config
export EDITOR='nvim'
export FZF_DEFAULT_COMMAND='fd --type f'

# Paths.
export ANDROID_HOME="$HOME/Android/Sdk"
export ANDROID_SDK_HOME="$HOME/Android/Sdk"
export ANDROID_NDK_HOME="$ANDROID_HOME/ndk/22.0.6917172"
export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$ANDROID_SDK_HOME/build-tools/30.0.2"

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

tmux -u
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$ANDROID_NDK:$PATH"

# Created by `userpath` on 2020-02-03 14:05:48
export PATH="$PATH:/home/dave/.local/bin"

eval $(thefuck --alias)

PATH="/home/dave/perl5/bin${PATH:+:${PATH}}"; export PATH;
PERL5LIB="/home/dave/perl5/lib/perl5${PERL5LIB:+:${PERL5LIB}}"; export PERL5LIB;
PERL_LOCAL_LIB_ROOT="/home/dave/perl5${PERL_LOCAL_LIB_ROOT:+:${PERL_LOCAL_LIB_ROOT}}"; export PERL_LOCAL_LIB_ROOT;
PERL_MB_OPT="--install_base \"/home/dave/perl5\""; export PERL_MB_OPT;
PERL_MM_OPT="INSTALL_BASE=/home/dave/perl5"; export PERL_MM_OPT;
