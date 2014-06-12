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
Bundle 'kien/ctrlp.vim'
Bundle 'nginx.vim'
Bundle 'pld-linux/vim-syntax-vcl'
Bundle 'scrooloose/nerdtree'
Bundle 'scrooloose/syntastic'
Bundle 'tpope/vim-fugitive'

" Show line numbers
set number

" Indent
set cindent
set tabstop=4     " an hard TAB displays as 4 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=4 " insert/delete 4 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
set textwidth=79  " lines longer than 79 columns will be broken
set shiftwidth=4  " operation >> indents 4 columns; << unindents 4 columns

set cursorline " have a line indicate the cursor location
set ruler " show the cursor position all the time

" Color scheme
syntax enable
set background=light
colorscheme solarized
if has('gui_running')
  set guifont=Ubuntu\ Mono\ 14
endif

" sudo write this
cmap W! w !sudo tee % >/dev/null

" sort lines
vmap <F9> :sort<CR>

" remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" Aliases
cab Q! q!
cab Wq wq
cab Wa wa
cab wQ wq
cab WQ wq
cab W w
cab Q q

