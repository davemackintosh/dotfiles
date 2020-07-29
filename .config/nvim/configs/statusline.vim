set laststatus=2
hi User1 ctermbg=004 ctermfg=015 " Blue background, white foreground
hi User2 ctermbg=005 ctermfg=015 " Pink background, white foreground
hi User3 ctermbg=005 ctermfg=004 " Pink background, blue foreground
hi User4 ctermbg=NONE ctermfg=005 " No background, pink foreground.
hi User5 ctermbg=NONE ctermfg=004 " No background, pink foreground.

set statusline =
set statusline+=%1*\ %{toupper(mode())}\ 
set statusline+=%3*
set statusline+=%2*\ %{expand('%:e')}\ 
set statusline+=%2*\ %t@%l:%c\ 
set statusline+=%4*

au BufEnter,BufWinEnter,WinEnter,CmdwinEnter *
                       \ call s:disable_statusline('[defx] default-0')
au BufEnter,BufWinEnter,WinEnter,CmdwinEnter *
                       \ call s:disable_statusline('__vista__')

fun! s:disable_statusline(bn)
  if a:bn == bufname('%')
    set laststatus=0
  else
    set laststatus=2
  endif
endfunction
