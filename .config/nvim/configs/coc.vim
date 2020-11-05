 let g:coc_global_extensions = [
  \ 'coc-tsserver',
	\ 'coc-json',
	\ 'coc-github',
	\ 'coc-git',
	\ 'coc-html',
	\ 'coc-css',
	\ 'coc-svg',
	\ 'coc-marketplace',
	\ 'coc-prettier',
	\ 'coc-eslint',
	\ 'coc-rls',
	\ 'coc-rust-analyzer',
  \ ]

 " Show a description on cursor hover
function! ShowDocIfNoDiagnostic(timer_id)
  if (coc#float#has_float() == 0)
    silent call CocActionAsync('doHover')
  endif
endfunction

function! s:show_hover_doc()
  silent call timer_start(500, 'ShowDocIfNoDiagnostic')
endfunction

autocmd CursorHoldI * :call <SID>show_hover_doc()
autocmd CursorHold * :call <SID>show_hover_doc()

"""" </ Cursor Hover

" Auto fix.
nmap <leader>do <Plug>(coc-codeaction)

" Diagnostics list.
nnoremap <silent> <space>d :<C-u>CocList diagnostics<cr>
