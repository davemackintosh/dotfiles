set nocompatible

call plug#begin('~/.config/nvim/bundle')
	" File plugins.
  Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
	Plug 'kristijanhusak/defx-icons'
	Plug 'ctrlpvim/ctrlp.vim'

	" Status plugins
  Plug 'itchyny/lightline.vim'
  Plug 'liuchengxu/vista.vim'

	" SCM plugins
	Plug 'tpope/vim-fugitive'

	" Code plugins
  Plug 'neoclide/coc.nvim', {'do': './install.sh nightly'}
  Plug 'ludovicchabant/vim-gutentags'

  " Look and feel plugins
  Plug 'mhartington/oceanic-next'
call plug#end()

" Path to the vim config.
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

