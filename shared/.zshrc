# Set some envs.
export ZSH=$HOME/.oh-my-zsh
export ZPLUG_HOME=$HOME/dotfiles/.zplug
export DEFAULT_TPM_PATH=$HOME/dotfiles/.tpm
eval "$(direnv hook zsh)"

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
zplug "romkatv/powerlevel10k", as:theme, depth:1
# zplug "modules/tmux",   from:prezto
zplug "modules/history", from:prezto
zplug "modules/utility", from:prezto
zplug "modules/ssh", from:prezto
zplug "modules/terminal",   from:prezto
zplug "modules/editor",   from:prezto
zplug "modules/directory", from:prezto
zplug "modules/completion",  from:prezto
zplug "zsh-users/zsh-completions", defer:0
zplug "zsh-users/zsh-autosuggestions", defer:2, on:"zsh-users/zsh-completions"
zplug "zsh-users/zsh-syntax-highlighting", defer:3, on:"zsh-users/zsh-autosuggestions"
zplug "zsh-users/zsh-history-substring-search", defer:3, on:"zsh-users/zsh-syntax-highlighting"
zplug "plugins/git", from:oh-my-zsh
zplug "skywind3000/z.lua"

if ! zplug check --verbose; then
	echo; zplug install
fi

zplug load

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
 source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Source anything else here
source ~/.p10k.zsh
source ~/paths.zsh
source ~/aliases.zsh
source ~/keybindings.zsh

export GPG_TTY=$(tty)

# Start tmux
tmux
