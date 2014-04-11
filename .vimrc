set nocompatible
filetype off
filetype plugin on
filetype plugin indent on

" Bundle management
set rtp+=~/.vim/bundle/vundle/
call vundle#rc()
Bundle 'gmarik/vundle'

" Bundles 
Bundle 'kien/ctrlp.vim'
Bundle 'tpope/vim-fugitive'
Bundle 'scrooloose/nerdtree'
Bundle 'altercation/vim-colors-solarized'
Bundle 'nginx.vim'
Bundle 'pld-linux/vim-syntax-vcl'
Bundle 'Pydiction'

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

" Code completion
let g:pydiction_location = '~/.vim/bundle/Pydiction/complete-dict'

" Color scheme
syntax enable
set background=light
colorscheme solarized
if has('gui_running')
  set guifont=Ubuntu\ Mono\ 14
endif

" Aliases
cab W! w!
cab Q! q!
cab Wq wq
cab Wa wa
cab wQ wq
cab WQ wq
cab W w
cab Q q

