export CLICOLOR=1
export GPG_TTY="$(tty)"
export NVM_DIR="$HOME/.nvm"
export EDITOR=nvim
export STARSHIP_CONFIG="$HOME/dotfiles/starship.toml"

# Kill whatever process is using a port.
function killPort {
	kill -9 $(lsof -i TCP:$1 | grep LISTEN | awk '{print $2}')
}
