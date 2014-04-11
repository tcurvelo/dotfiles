set nocompatible
filetype off
filetype plugin on
filetype plugin indent on

" Bundle management
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Bundles 
Bundle 'altercation/vim-colors-solarized'
Bundle 'nginx.vim'
Bundle 'Pydiction'
Bundle 'https://github.com/pld-linux/vim-syntax-vcl.git'

" Show line numbers
set number

" Indent
set cindent
set tabstop=4
set shiftwidth=4
set expandtab

" Code completion
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

" Color scheme
syntax enable
set background=light
colorscheme solarized

