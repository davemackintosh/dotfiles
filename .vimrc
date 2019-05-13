set nocompatible              " be iMproved, required
filetype off                  " required

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'git://git.wincent.com/command-t.git'
Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
Plugin 'scrooloose/syntastic'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'eslint/eslint'
Plugin 'yannickcr/eslint-plugin-react'
Plugin 'tonsky/firacode'
Plugin 'scrooloose/nerdtree'
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'itchyny/lightline.vim'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'tpope/vim-eunuch'
Plugin 'tpope/vim-surround'
Plugin 'w0rp/ale'
Plugin 'wesQ3/vim-windowswap'
Plugin 'othree/html5.vim'
Plugin 'chrisbra/Colorizer'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'thaerkh/vim-workspace'
Plugin 'mhartington/oceanic-next'
Plugin 'othree/yajs.vim'
Plugin 'othree/es.next.syntax.vim'
Plugin 'pangloss/vim-javascript'
Plugin 'Quramy/tsuquyomi'
Plugin 'leafgarland/typescript-vim'
Plugin 'luochen1990/rainbow'

if has('nvim')
  Plugin 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plugin 'Shougo/deoplete.nvim'
  Plugin 'roxma/nvim-yarp'
  Plugin 'roxma/vim-hug-neovim-rpc'
endif

let g:rainbow_active = 1
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_flow = 1
let g:deoplete#ignore_sources = get(g:, 'deoplete#ignore_sources', {})
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1
let g:deoplete#ignore_sources.js = ['omni']
let g:deoplete#ignore_sources.ts = ['omni']

set mouse=a
set clipboard=unnamed
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*/node_modules/*
set background=dark
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn|node_modules)$',
  \ }

Plugin 'wokalski/autocomplete-flow'
" For func argument completion
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
call vundle#end()            " required

filetype plugin indent on    " required

autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS

syntax enable

colorscheme OceanicNext

au BufNewFile *.vim,*.pl,*.sh set fileformat=unix

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set expandtab
set number
set tabstop=2
set softtabstop=2
set shiftwidth=2



" Key bindings
map <C-o> :NERDTreeToggle<CR>
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
map <F2> :mksession! ./vim_session <cr>
map <F3> :source ./vim_session <cr>

autocmd vimenter * NERDTree

function! CDToGitRoot()
  let gitdir=fnameescape(substitute(system('git rev-parse --show-toplevel'), '\n', '', ''))
  let isnotgitdir=matchstr(gitdir, '^fatal:.*')

  if empty(isnotgitdir)
    cd `=gitdir`
  endif
endfunction

" Check if NERDTree is open or active
function! IsNERDTreeOpen()
  return exists("t:NERDTreeBufName") && (bufwinnr(t:NERDTreeBufName) != -1)
endfunction

" Call NERDTreeFind iff NERDTree is active, current window contains a modifiable
" file, and we're not in vimdiff
function! SyncTree()
  if &modifiable && IsNERDTreeOpen() && strlen(expand('%')) > 0 && !&diff
    NERDTreeFind
    wincmd p
  endif
endfunction

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-y': 'vsplit' }

" Highlight currently open buffer in NERDTree
autocmd BufEnter * call SyncTree()

" CD to the git root if one exists for saving/loading sessions.
autocmd BufEnter * call CDToGitRoot()

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

let g:NERDTreeDirArrowExpandable = '▸'
let g:NERDTreeDirArrowCollapsible = '▾'
let NERDTreeShowHidden=1

let g:ale_linters = {
\  'javascript': ['eslint', 'flow']
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\   'typescript': ['tslint'],
\}
let b:ale_fix_on_save = 1
autocmd BufWritePost *.js,*.jsx,*.json,*.ts ALEFix

let g:airline_theme='bubblegum'

highlight clear ALEWarningSign " otherwise uses error bg color (typically red)
hi Normal ctermbg=NONE ctermfg=NONE
let g:ale_sign_error = 'X' " could use emoji
let g:ale_sign_warning = '?' " could use emoji
let g:ale_statusline_format = ['X %d', '? %d', '']
" %linter% is the name of the linter that provided the message
" %s is the error or warning message
let g:ale_echo_msg_format = '%linter% says %s'
