pkg i git tmux neovim rust golang nodejs python lua53 luarocks ripgrep fd zoxide fish direnv getconf

pip install pre-commit neovim
npm install neovim

# install terminal config.
ln -sf ~/dotfiles/.termux $HOME/
cp "./patched-fonts/CozetteVector Nerd Font Complete Mono.ttf" $HOME/.termux/font.ttf

# Install starship (note the specifics for termux here.)
echo "Installing Starship\n"
curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir /data/data/com.termux/files/usr/bin

