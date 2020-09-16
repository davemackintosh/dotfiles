" Editor config.
filetype plugin indent on

set mouse=a
set clipboard=unnamed
set nobackup
set nowritebackup
set noswapfile
set noexpandtab

" Keep our dotfiles away from commands such as :Gstatus
" https://github.com/tpope/vim-fugitive/issues/1176
set shell=/usr/bin/bash

set colorcolumn=80
highlight ColorColumn ctermbg=magenta
call matchadd('ColorColumn', '\%81v', 100)

let g:rustfmt_autosave = 1
