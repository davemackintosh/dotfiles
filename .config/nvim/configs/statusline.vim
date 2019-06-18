hi User1 ctermbg=004 ctermfg=015
hi User2 ctermbg=005 ctermfg=015
hi User3 ctermfg=005 ctermbg=NONE
hi User4 ctermfg=004 ctermbg=NONE

function! GetFIcon(ext)
let ext = expand('%:e')
let icons = defx_icons#get()
  if has_key(icons.extensions, ext)
    return icons.extensions[ext].icon
  else
    return icons.default_icon
  endif
  return ''
endfunction

set statusline =
set statusline+=%1*\ %{toupper(mode())}\ 
set statusline+=%4*
set statusline+=%2*\ %{GetFIcon(expand('%:e'))}\ 
set statusline+=%2*\ %t@%l:%c\ 
set statusline+=%3*
set statusline+=%0*


