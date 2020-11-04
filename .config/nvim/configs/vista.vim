let g:vista_default_executive = 'ctags'

let g:vista_executive_for = {
  \ 'go': 'ctags',
  \ 'rust': 'ctags',
  \ 'javascript': 'coc',
  \ 'typescript': 'coc',
  \ 'typescript.tsx': 'coc',
  \ 'javascript.jsx': 'coc',
  \ 'python': 'coc',
  \ }

" Ensure you have installed some decent font to show these pretty symbols, then you can enable icon for the kind.
let g:vista#renderer#enable_icon = 1

" The default icons can't be suitable for all the filetypes, you can extend it as you wish.
let g:vista#renderer#icons = {
\   "function": "\uf794",
\   "variable": "\uf71b",
\  }

let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]

