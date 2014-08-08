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
Bundle 'mattn/emmet-vim'
Bundle 'jelera/vim-javascript-syntax'
Bundle 'pangloss/vim-javascript'
Bundle 'bling/vim-airline'
Bundle 'nathanaelkane/vim-indent-guides'
Bundle 'Valloric/YouCompleteMe'
Bundle 'Valloric/MatchTagAlways'
Bundle 'majutsushi/tagbar'

" Indent
set cindent
set tabstop=2     " an hard TAB displays as 2 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=2 " insert/delete 2 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
set shiftwidth=2  " operation >> indents 2 columns; << unindents 2 columns
let g:indent_guides_enable_on_vim_startup = 1
let g:indent_guides_guide_size = 1


" Indent in *.py is 4 columns long
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 textwidth=79
autocmd FileType rst,txt setlocal noautoindent nocindent nosmartindent indentexpr=
autocmd FileType rst,txt,mo setlocal spell spelllang=en,pt

set number      " show line numbers
set cursorline  " have a line indicate the cursor location
set ruler       " show the cursor position all the time
set wildmenu    " visual autocomplete for command menu
set incsearch   " search as characters are entered
set hlsearch    " highlight matches
set colorcolumn=80 " vertical line at column 80

" Color scheme
syntax enable
set background=light
colorscheme solarized
if has('gui_running')
  if has('gui_gtk2')
    set guifont=Ubuntu\ Mono\ derivative\ powerline\ 13
  elseif has('gui_win32')
    set guifont=Ubuntu_Mono_Derivative_powerlin:h13:cANSI
  endif
endif
set encoding=utf-8

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

" airline bar settings
let g:airline_powerline_fonts = 1
set laststatus=2
set t_Co=256
set noshowmode

