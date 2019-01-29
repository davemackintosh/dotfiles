setupTermuxStorage:
ifeq ("$OS", "Android")
  termux-setup-storage
endif
  
aptTasks:
  apt update
  apt install ctags zsh openssh git clang curl wget nodejs
  
nvimTasks:
  apt install python python2 python-dev neovim
  pip install neovim
  yarn add -G neovim
  [[ ! -d ~/.vim/bundle/Vundle.vim ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  cp .ctags "$HOME/"
  cp -R .config/nvim $HOME/.config
  nvim +UpdateRemotePlugins +qall
  nvim +PluginClean! +qall
  nvim +PluginInstall +qall
  
ohMyZSHTasks:
  wget -O "$HOME/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh"
  cp .zshrc "$HOME/.zshrc"
  sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"
  test ! -f "$HOME/.ssh/id_rsa.pub" && ssh-keygen -t rsa
  
all:
  make aptTasks
  npm i -g yarn
  make setupTermuxStorage
  make ohMyZSHTasks
  make nvimTasks
  
  yarn add -G flow-bin eslint flow-node
  
