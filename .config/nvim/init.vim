set nocompatible

" Ignore dotfiles when opening Fugitive
" so it opens pretty instantly instead of 
" setting up an entire environment.
" https://github.com/tpope/vim-fugitive/issues/1176
set shell=/bin/bash

call plug#begin('~/.config/nvim/bundle')
	Plug 'christoomey/vim-tmux-navigator'

	" File plugins.
	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'kristijanhusak/defx-icons'
	Plug '/usr/local/opt/fzf'
	Plug 'junegunn/fzf.vim'
	Plug 'editorconfig/editorconfig-vim'

	" Status plugins
	Plug 'liuchengxu/vista.vim'

	" SCM plugins
	Plug 'tpope/vim-fugitive', { 'on': [] }
	Plug 'kristijanhusak/defx-git'

	" Code plugins
	Plug 'neoclide/coc.nvim', {'branch': 'release'}
	Plug 'dense-analysis/ale'
	Plug 'ludovicchabant/vim-gutentags'
	Plug 'terryma/vim-multiple-cursors'
	" Plug 'eslint/eslint'
	" Plug 'yannickcr/eslint-plugin-react'
	Plug 'HerringtonDarkholme/yats.vim'
	Plug 'ap/vim-css-color'
	" Plug 'prabirshrestha/async.vim'
	" Plug 'prabirshrestha/vim-lsp'
	" Plug 'ryanolsonx/vim-lsp-typescript'
	" Plug 'pangloss/vim-javascript'
	" Plug 'leafgarland/typescript-vim'
	" Plug 'peitalin/vim-jsx-typescript'
	Plug 'styled-components/vim-styled-components', { 'branch': 'main' }
	Plug 'jparise/vim-graphql'

	" Look and feel plugins. I'm so very fickle.
	" these are my favourites.
	Plug 'arcticicestudio/nord-vim'
	Plug 'sonph/onehalf', {'rtp': 'vim/'}
call plug#end()

" Directory path to the vim config.
let s:path = fnamemodify(expand('$MYVIMRC'), ':h')

" Glob and source all the files in `path`
function! SourceAllIn(path)
	for s:fpath in split(globpath(s:path . a:path, '*.vim'), '\n')
		exe 'source' s:fpath
	endfor
endfunction

let mapleader=","

" Get our files.
call SourceAllIn('/configs/')
call SourceAllIn('/mappings/')

" I do this a lot. this saves me a lot
" of time. 
map <C-u> :source $MYVIMRC<CR>

" Because apparently I can't let go of 
" Shift fast enough. Alias this.
command! W :write

