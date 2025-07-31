fish install-common.fish

# Install some configs.
echo "Installing standalone dotfiles.\n"
if test -d $HOME/.config/fish
	mv $HOME/.config/fish $HOME/.config/fish.BAK
end
if test -d $HOME/.config/alacritty
	mv $HOME/.config/alacritty $HOME/.config/alacritty.BAK
end
ln -sf $HOME/dotfiles/fish $HOME/.config/
ln -sf $HOME/dotfiles/.gitconfig $HOME/
ln -sf $HOME/dotfiles/.tmux.conf $HOME/
ln -sf $HOME/dotfiles/starship.toml $HOME/.config/

# If it's not Termux.
if test -z "$TERMUX_VERSION"
	fish install-unix-common.fish

	if type -q apt
		fish install-apt.fish
	else if type -q pacman
		fish install-pacman.fish
	end
else
	fish install-termux.fish
end

# Install Nvim dotfiles.
if test -z "$NO_NVIM"
	echo "Installing Neovim dotfiles\n"
	if not test -d "$HOME/.config/nvim"
		if test -f "$HOME/.ssh/id_ecdsa.pub"
			git clone git@github.com:davemackintosh/nvim $HOME/.config/nvim
		else
			echo -e "WARN: No SSH key so cloning read only nvim config"
			git clone https://github.com/davemackintosh/nvim $HOME/.config/nvim
		end
	else
		mv "$HOME/.config/nvim" "$HOME/.config/nvim.BAK"
		if test -f "$HOME/.ssh/id_ecdsa.pub"
			git clone git@github.com:davemackintosh/nvim $HOME/.config/nvim
		else
			echo -e "WARN: No SSH key so cloning read only nvim config"
			git clone https://github.com/davemackintosh/nvim $HOME/.config/nvim
		end
	end
end

source "$HOME/dotfiles/exports.fish"
source "$HOME/dotfiles/paths.fish"
source "$HOME/dotfiles/aliases.fish"
