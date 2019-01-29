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
  [[ ! -d ~/.vim/bundle/Vundle.vim ]] && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  npm i -g neovim
  mkdir -p $HOME/.config/nvim
  mv .config-nvim-init.vim $HOME/.config/nvim/init.vim
  nvim +UpdateRemotePlugins +qall
  nvim +PluginClean! +qall &&
  nvim +PluginInstall +qall &&
  
ohMyZSHTasks:
  wget -O $HOME/z.sh https://raw.githubusercontent.com/rupa/z/master/z.sh 
  cp .zshrc $HOME/.zshrc
  sh -c "$(curl -fsSL https://github.com/Cabbagec/termux-ohmyzsh/raw/master/install.sh)"
  test ! -f $HOME/.ssh/id_rsa.pub && ssh-keygen -t rsa
  
all:
  make setupTermuxStorage
  make ohMyZSHTasks
  make aptTasks 
  make nvimTasks
  
  npm i -g yarn
  yarn add -G flow-bin eslint flow-node
  
