export CLICOLOR=1
export GPG_TTY="$(tty)"
export EDITOR=nvim
export STARSHIP_CONFIG="$HOME/dotfiles/starship.toml"

# If we're in WSL land, we need to use pass as the backend.
if not test -d "/opt/homebrew/"
	export AWS_VAULT_BACKEND=pass
end
