" Plug wants to lazy load everything 
" but Fugitive can't be lazy loaded.
" Found this code at the link below.
" @link https://github.com/junegunn/vim-plug/issues/164#issuecomment-366483364
command! Gstatus call LazyLoadFugitive('Gstatus') command! Gdiff call LazyLoadFugitive('Gdiff') 
command! Merge call LazyLoadFugitive('Gvdiff') command! Gdiff call LazyLoadFugitive('Gvdiff') 
command! Glog call LazyLoadFugitive('Glog') 
command! Gblame call LazyLoadFugitive('Gblame') 

function! LazyLoadFugitive(cmd) 
  call plug#load('vim-fugitive') 
  call fugitive#detect(expand('%:pwd')) 
  exe a:cmd 
endfunction
