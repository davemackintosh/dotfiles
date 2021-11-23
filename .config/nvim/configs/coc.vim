 let g:coc_global_extensions = [
  \ 'coc-tsserver',
	\ 'coc-json',
	\ 'coc-github',
	\ 'coc-explorer',
	\ 'coc-git',
	\ 'coc-html',
	\ 'coc-css',
	\ 'coc-svg',
	\ 'coc-marketplace',
	\ 'coc-prettier',
	\ 'coc-eslint',
  \ ]

" Auto fix.
nmap <leader>do <Plug>(coc-codeaction)

" Diagnostics list.
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>

set updatetime=300
