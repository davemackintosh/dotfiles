export GOENV_ROOT="$HOME/.goenv"

export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$GOENV_ROOT/bin:$PATH"
export PATH="$GOROOT/bin:$PATH"
export PATH="$PATH:$GOPATH/bin"
export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"
export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
export PATH="$HOME/.pyenv/bin:$PATH"

if [[ "$OSTYPE" == "darwin"* ]]; then
	export MOLTENVK_HOME="$HOME/www/cpp/MoltenVK/MoltenVK"
	export PATH="$PATH:$HOME/Library/Python/3.8/bin"
fi

