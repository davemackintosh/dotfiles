source ~/dotfiles/exports.zsh

# Check we've got what we need.
if [[ ! -d $ZPLUG_HOME ]]; then
 git submodule update --init --recursive &&
 source $ZPLUG_HOME/init.zsh && zplug update
else
 source $ZPLUG_HOME/init.zsh
fi

# Zplug plugins
zplug "zplug/zplug", hook-build:"zplug --self-manage"

# ZSH Plugins
zplug "zsh-users/zsh-history-substring-search"
zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions", defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"
zplug "plugins/command-not-found", from:oh-my-zsh
zplug "skywind3000/z.lua"
zplug "RiverGlide/zsh-goenv", from:gitlab

if ! zplug check --verbose; then
	echo; zplug install
fi

zplug load

# Source anything else here
source ~/dotfiles/paths.zsh
source ~/dotfiles/aliases.zsh
source ~/dotfiles/keybindings.zsh
source ~/.cargo/env

eval "$(starship init zsh)"
eval "$(goenv init -)"
eval "$(direnv hook zsh)"
eval "$(thefuck --alias)"
eval "$(pyenv init --path)"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -s ~/.luaver/luaver ] && . ~/.luaver/luaver
HB_CNF_HANDLER="$(brew --repository)/Library/Taps/homebrew/homebrew-command-not-found/handler.sh"
if [ -f "$HB_CNF_HANDLER" ]; then
source "$HB_CNF_HANDLER";
fi

# Start tmux
tmux new-session -A -s dev
