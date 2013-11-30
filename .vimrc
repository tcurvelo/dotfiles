set nocompatible
filetype off

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


Bundle 'gmarik/vundle'

" My bundles
Bundle 'nginx.vim'
Bundle 'https://github.com/pld-linux/vim-syntax-vcl.git'


set number


" Indent
filetype plugin indent on
set cindent
set tabstop=4
set shiftwidth=4
set expandtab

