" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim

if &shell =~# 'fish$'
    set shell=zsh
endif
let mapleader = ","
let maplocalleader = ","

call plug#begin('~/.vim/plugged')
Plug 'scrooloose/nerdtree'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dag/vim-fish'
Plug 'lervag/vimtex'
call plug#end()

" set relativenumber
set number
set ruler
set cc=80
set cursorline
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab
noremap <Up>       :echoerr "Use k instead!"<CR>$
noremap <Down>     :echoerr "Use j instead!"<CR>$
noremap <Left>     :echoerr "Use l instead!"<CR>$
noremap <Right>    :echoerr "Use h instead!"<CR>$,
map j gj
map k gk
set statusline=\ %F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ %=\ Line:\ %l;%c\ 
set laststatus=2
hi LineNr cterm=bold 
filetype plugin on

let g:vimtex_view_method = 'zathura'
let g:vimtex_quickfix_latexlog = {
      \ 'packages' : {
      \   'biblatex' : 0,
      \ },
      \}
let mapleader =","
let maplocalleader =","
let g:rustfmt_options = '--edition 2018'
let g:rustfmt_autosave = 1

let g:vimtex_quickfix_latexlog = {
      \ 'packages' : {
      \   'biblatex' : 0,
      \ },
      \}

let g:autopep8_on_save = 1
function! Tab_Or_Complete()
  if col('.')>1 && strpart( getline('.'), col('.')-2, 3 ) =~ '^\w'
    return "\<C-N>"
  else
    return "\<Tab>"
  endif
endfunction
inoremap <Tab> <C-R>=Tab_Or_Complete()<CR>
