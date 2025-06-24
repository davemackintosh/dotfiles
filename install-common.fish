# Pull and install any dependencies.
git submodule update --init --recursive --remote

curl -s "https://get.sdkman.io" | bash

fisher install

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
echo "\tinstalling asdf python\n"
asdf plugin-add python
echo "\tinstalling asdf aws-vault"
asdf plugin-add aws-vault https://github.com/karancode/asdf-aws-vault.git

asdf install
