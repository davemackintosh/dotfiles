# System paths.
export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/Library/Python/3.8/bin"
export GOENV_ROOT="$HOME/.goenv"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"

export MOLTENVK_HOME="$HOME/www/cpp/MoltenVK/MoltenVK"

# Language specifics.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
source "$HOME/.cargo/env"
eval $(thefuck --alias)
