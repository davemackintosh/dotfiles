# Pull our dependencies.
git submodule update --init --recursive --remote

if not test -d ~/.asdf
	ln -sf $HOME/dotfiles/.tool-versions $HOME/
	git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.0
	source ~/.asdf/asdf.fish
	mkdir -p ~/.config/fish/completions; and ln -s ~/.asdf/completions/asdf.fish ~/.config/fish/completions
end

# Install plugins.
echo "installing asdf plugins\n"
echo "\tinstalling asdf go\n"
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
echo "\tinstalling asdf nodejs\n"
asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
echo "\tinstalling asdf rust\n"
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
echo "\tinstalling asdf python\n"
asdf plugin-add python
echo "\tinstalling asdf aws-vault"
asdf plugin-add aws-vault https://github.com/karancode/asdf-aws-vault.git

asdf install

# Install some configs.
echo "Installing standalone dotfiles.\n"
if test -d $HOME/.config/fish
	mv $HOME/.config/fish $HOME/.config/fish.BAK
end
ln -sf $HOME/dotfiles/fish $HOME/.config/
ln -sf $HOME/dotfiles/.gitconfig $HOME/
ln -sf $HOME/dotfiles/.tmux.conf $HOME/
mkdir -p $HOME/.config/efm-langserver/ || true
ln -sf $HOME/dotfiles/efm-langserver/.config.yaml $HOME/.config/efm-langserver/
ln -sf $HOME/dotfiles/starship.toml $HOME/.config/

# If it's not Termux.
if test -z "$TERMUX_VERSION"
	# Install Starship
	echo "Installing Starship\n"
	curl -sS https://starship.rs/install.sh | sh
else
	pkg i -y getconf

	# install terminal config.
	ln -sf ~/dotfiles/.termux $HOME/
	cp "./patched-fonts/CozetteVector Nerd Font Complete Mono.ttf" $HOME/.termux/font.ttf

	# Install starship (note the specifics for termux here.)
	echo "Installing Starship\n"
	curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir /data/data/com.termux/files/usr/bin
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


	if not test -z "$TERMUX_VERSION"
		pkg i neovim fzf fd ripgrep nodejs go rust clang
		$HOME/.config/nvim/collateral/dependencies
	end
end

source "$HOME/dotfiles/exports.fish"
source "$HOME/dotfiles/paths.fish"
source "$HOME/dotfiles/aliases.fish"
