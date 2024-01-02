if test -z "$TERMUX_VERSION"
	export GOENV_ROOT="$HOME/.goenv"
	export PATH="$PATH:/home/linuxbrew/.linuxbrew/bin"
	export PATH="$PATH:$HOME/.gem/ruby/2.6.0/bin"
end

export PATH="$PATH:$HOME/node_modules/.bin"
export PATH="$PATH:$HOME/.yarn/bin"
export PATH="$PATH:$HOME/.config/yarn/global/node_modules/.bin"
export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:$HOME/.cargo/bin"
export PATH="$PATH:$(go env GOPATH)/bin"
export PATH="$HOME/.pyenv/bin:$PATH"

eval "$(direnv hook fish)"
