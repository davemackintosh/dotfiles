set -U fish_greeting

if status is-interactive
	zoxide init fish | source
	source $HOME/dotfiles/paths.zsh
	source $HOME/dotfiles/aliases.zsh
end
