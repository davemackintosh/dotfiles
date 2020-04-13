set nocompatible

" Ignore dotfiles when opening Fugitive
" so it opens pretty instantly instead of 
" setting up an entire environment.
set shell=/bin/bash\ --login

call plug#begin('~/.config/nvim/bundle')
  Plug 'christoomey/vim-tmux-navigator'

	" File plugins.
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'kristijanhusak/defx-icons'
  Plug '/usr/local/opt/fzf'
  Plug 'junegunn/fzf.vim'

	" Status plugins
  " Plug 'itchyny/lightline.vim' " If you use this, its worth removing the
  " .vim suffix from configs/statusline.vim
  Plug 'liuchengxu/vista.vim'

	" SCM plugins
	Plug 'tpope/vim-fugitive', { 'on': [] }
  Plug 'kristijanhusak/defx-git'

	" Code plugins
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'ludovicchabant/vim-gutentags'
  Plug 'terryma/vim-multiple-cursors'
  Plug 'eslint/eslint'
  Plug 'yannickcr/eslint-plugin-react'
  Plug 'HerringtonDarkholme/yats.vim'
  Plug 'ap/vim-css-color'
  Plug 'prabirshrestha/async.vim'
  Plug 'prabirshrestha/vim-lsp'
  Plug 'ryanolsonx/vim-lsp-typescript'
  Plug 'rust-lang/rust.vim'
  Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
  Plug 'rhysd/vim-clang-format'
  Plug 'dart-lang/dart-vim-plugin'
  Plug 'beyondmarc/glsl.vim'

  " Look and feel plugins. I'm so very fickle.
  " these are my favourites.
  Plug 'mhartington/oceanic-next'
  Plug 'flrnd/candid.vim'
  Plug 'arcticicestudio/nord-vim'
  Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
  Plug 'arcticicestudio/nord-vim'
call plug#end()

" Directory path to the vim config.
let s:path = fnamemodify(expand('$MYVIMRC'), ':h')

" Glob and source all the files in `path`
function! SourceAllIn(path)
	for s:fpath in split(globpath(s:path . a:path, '*.vim'), '\n')
		exe 'source' s:fpath
	endfor
endfunction

" Get our files.
call SourceAllIn('/configs/')
call SourceAllIn('/mappings/')

" I do this a lot. this saves me a lot
" of time. 
map <C-u> :source $MYVIMRC<CR>

" Because apparently I can't let go of 
" Shift fast enough. Alias this.
command! W :write

