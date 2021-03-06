filetype on
syntax on 
colorscheme Tomorrow-Night
filetype plugin indent on

set number
set colorcolumn=90
set nocompatible
set hidden
set history=100
set hlsearch
set smartindent
set tabstop=4
set softtabstop=4
set shiftwidth=4

let mapleader=" "

noremap ø l
noremap l k
noremap k j
noremap j h
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>
nmap <leader>rf vapqg

call plug#begin()

Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'xuhdev/vim-latex-live-preview'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'lervag/vimtex'

call plug#end()

set laststatus=2
set noshowmode
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'component': {
      \   'readonly': '%{&readonly?"x":""}',
      \ },
      \ 'separator': { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '|', 'right': '|' }
      \ }

