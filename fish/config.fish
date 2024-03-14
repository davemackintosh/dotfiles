set -U fish_greeting

source $HOME/.asdf/asdf.fish
source $HOME/dotfiles/paths.fish

if status is-interactive
	zoxide init fish | source
	starship init fish | source

	source $HOME/dotfiles/aliases.fish
end
