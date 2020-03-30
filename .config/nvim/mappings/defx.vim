" Open or close Defx
map <silent><C-o> :Defx -resume<CR>

autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
	" Opening folders/files.
  nnoremap <silent><buffer><expr> <CR>
        \ defx#is_directory() 
					\ ? defx#do_action('open_or_close_tree') 
					\ : defx#do_action('drop')
  nnoremap <silent><buffer><expr> s
        \ defx#do_action('multi', [['drop', 'split']])
  nnoremap <silent><buffer><expr> v
        \ defx#do_action('multi', [['drop', 'vsplit']])

	" FS info
	nnoremap <silent><buffer><expr> yp
    \ defx#do_action('yank_path')

	" File manipulation.
  nnoremap <silent><buffer><expr> yy
	  \ defx#do_action('copy')
	nnoremap <silent><buffer><expr> dd
		\ defx#do_action('move')
	nnoremap <silent><buffer><expr> pp
		\ defx#do_action('paste')
	nnoremap <silent><buffer><expr> mm
		\ defx#do_action('rename')
	nnoremap <silent><buffer><expr> q
    \ defx#do_action('quit')
  nnoremap <silent><buffer><expr> <Space>
    \ defx#do_action('toggle_select') . 'j'
	nnoremap <silent><buffer><expr> ma
    \ defx#do_action('new_file')
	nnoremap <silent><buffer><expr> dD
    \ defx#do_action('remove')

	" Misc.
	nnoremap <silent><buffer><expr> <C-.>
    \ defx#do_action('toggle_ignored_files')
endfunction

