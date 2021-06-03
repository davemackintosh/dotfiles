" Moving between buffers.
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

" For search results
nnoremap <F12> :cnext<cr>
nnoremap <F10> :cprev<cr>

nn <expr> <C-Space> g:colors_name == "nord" ? ":colo onehalflight\<CR>" : ":colo nord\<CR>"
