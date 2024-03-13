set -U fish_greeting

if status is-interactive
	zoxide init fish | source
	starship init fish | source
	source $HOME/.asdf/asdf.fish
	source $HOME/dotfiles/paths.fish
	source $HOME/dotfiles/aliases.fish
end

