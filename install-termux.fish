pkg i -y getconf fd-find fzf rust ripgrep neovim tmux git

# install terminal config.
ln -sf ~/dotfiles/.termux $HOME/
cp "./patched-fonts/CozetteVector Nerd Font Complete Mono.ttf" $HOME/.termux/font.ttf

# Install starship (note the specifics for termux here.)
echo "Installing Starship\n"
curl -sS https://starship.rs/install.sh | sh -s -- --bin-dir /data/data/com.termux/files/usr/bin

