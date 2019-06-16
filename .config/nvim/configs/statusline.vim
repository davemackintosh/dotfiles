set termguicolors
hi User1 guifg=#000000 guibg=#4cbf99
hi User2 guifg=#000000 guibg=#4cbf99

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
set statusline+=%0*\ %{toupper(mode())}\ 
set statusline+=%1*\ %{GetFIcon(expand('%:e'))}
set statusline+=%1*\ %t@%l:%c
set statusline+=\ "\ue0be"
set statusline+=%6*
