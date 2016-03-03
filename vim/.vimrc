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

let mapleader=","

call plug#begin()

Plug 'itchyny/lightline.vim'
Plug 'ervandew/supertab'
Plug 'xuhdev/vim-latex-live-preview'
Plug 'scrooloose/nerdtree'
Plug 'nathanaelkane/vim-indent-guides'

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

