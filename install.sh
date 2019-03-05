ifeq ("$OS", "Android")
	termux-setup-storage &&
endif

# apt tasks.
apt update && 
apt upgrade &&
apt install -y ctags zsh openssh clang curl wget nodejs &&
	
# zsh tasks.
wget -O "$HOME/z.sh" https://raw.githubusercontent.com/rupa/z/master/z.sh &&
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting &&
cp .zshrc "$HOME/.zshrc" &&
npm i -G yarn typescript ts-node &&

ifeq ("$OS", "Android")
	sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)" &&
endif
ifeq ("$OS", "Linux")
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)" &&
endif

# nvim tasks.
apt install python python2 python-dev neovim &&
pip install neovim &&
yarn add -G neovim &&
[[ ! -d ~/.vim/bundle/Vundle.vim ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim &&
cp .ctags "$HOME/" &&
mkdir -p "$HOME/.config" &&
cp -R .config/nvim "$HOME/.config" &&
nvim +UpdateRemotePlugins +qall &&
nvim +PluginClean! +qall &&
nvim +PluginInstall +qall &&
	
test ! -f "$HOME/.ssh/id_rsa.pub" && ssh-keygen -f id_rsa -t rsa -N '' &&
echo "\nCreated a new public key, here it is:\n" &&
cat $HOME'/.ssh/id_rsa.pub
 
