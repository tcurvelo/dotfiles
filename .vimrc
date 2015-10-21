set nocompatible
filetype off
filetype plugin on

" Bundle management
" ------------------------------------------------------------------------------
if !1 | finish | endif

if has('vim_starting')
  if &compatible
    set nocompatible               " Be iMproved
  endif
  set runtimepath+=~/.vim/bundle/neobundle.vim/
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'


" Bundles
NeoBundle 'morhetz/gruvbox'
NeoBundle 'kien/ctrlp.vim'
NeoBundle 'sheerun/vim-polyglot'
NeoBundle 'pld-linux/vim-syntax-vcl'
NeoBundle 'scrooloose/nerdtree'
NeoBundle 'scrooloose/syntastic'
NeoBundle 'tpope/vim-fugitive'
NeoBundle 'mattn/emmet-vim'
NeoBundle 'pangloss/vim-javascript'
NeoBundle 'bling/vim-airline'
NeoBundle 'edkolev/tmuxline.vim'
NeoBundle 'Yggdroot/indentLine'
NeoBundle 'Valloric/YouCompleteMe'
NeoBundle 'Valloric/MatchTagAlways'
NeoBundle 'majutsushi/tagbar'
NeoBundle 'terryma/vim-multiple-cursors'
NeoBundle 'airblade/vim-gitgutter'
NeoBundle 'SirVer/ultisnips'
NeoBundle 'honza/vim-snippets'
NeoBundle 'scrooloose/nerdcommenter'
NeoBundle 'mfukar/robotframework-vim'
NeoBundle 'rking/ag.vim'

call neobundle#end()
filetype plugin indent on
NeoBundleCheck


" Basic settings
" -----------------------------------------------------------------------------
set encoding=utf-8

" Indent
set cindent
set tabstop=2     " an hard TAB displays as 2 columns
set expandtab     " insert spaces when hitting TABs
set softtabstop=2 " insert/delete 2 spaces when hitting a TAB/BACKSPACE
set shiftround    " round indent to multiple of 'shiftwidth'
set autoindent    " align the new line indent with the previous line
set shiftwidth=2  " operation >> indents 2 columns; << unindents 2 columns

" Indent in *.py is 4 columns long
autocmd FileType python setlocal shiftwidth=4 tabstop=4 softtabstop=4 textwidth=79
autocmd FileType rst,txt setlocal noautoindent nocindent nosmartindent indentexpr=
autocmd FileType rst,txt,po setlocal spell spelllang=en,pt

set number      " show line numbers
set cursorline  " have a line indicate the cursor location
set ruler       " show the cursor position all the time
set wildmenu    " visual autocomplete for command menu
set incsearch   " search as characters are entered
set hlsearch    " highlight matches
set colorcolumn=80 " vertical line at column 80

set wildignore+=*/tmp/*,*/data/*,/log/*,*/data/*,*.so,*.swp,*.zip
set wildignore+=*/parts/*,*/py27/*,*.pyc,*pyo
set wildignore+=*/node_modules/*,*/bower_components/*
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']


" Color scheme
"------------------------------------------------------------------------------
syntax enable
set background=light
colorscheme gruvbox
if has('gui_running')
  set guioptions-=T " remove toolbar
  set guioptions-=m " remove menubar
  set guioptions-=r " remove right-hand scrollbar
  set guioptions-=L " remove left-hand scrollbar
  if has('gui_gtk2')
    set guifont=Ubuntu\ Mono\ derivative\ powerline\ 13
  elseif has('gui_win32')
    set guifont=Ubuntu_Mono_Derivative_powerlin:h13:cANSI
  endif
endif

au BufRead,BufNewFile *.zcml set filetype=xml
au BufRead,BufNewFile *.conf set filetype=nginx
au BufRead,BufNewFile *.robot set filetype=robot

" Mappings
" ------------------------------------------------------------------------------

" shortcut for <esc>
imap jj <Esc>

" sudo write this
cmap W! w !sudo tee % >/dev/null

" sort lines
vmap <F9> :sort<CR>

nmap <silent> <F4> :TagbarToggle<CR>
noremap <F3> :NERDTreeToggle<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

" remove trailing spaces
autocmd BufWritePre * :%s/\s\+$//e

" clipboard's copy/cut/paste
noremap YY "+y<CR>
noremap P "+gP<CR>
noremap XX "+x<CR>

" Aliases
cab Q! q!
cab Wq wq
cab Wa wa
cab wQ wq
cab WQ wq
cab W w
cab Q q


" Plugins settings
" ------------------------------------------------------------------------------

" airline bar settings
if !empty($DISPLAY)
  let g:airline_powerline_fonts = 1
else
  let g:airline_powerline_fonts = 0
  let g:tmuxline_powerline_separators = 0
endif

set laststatus=2
set t_Co=256
set noshowmode

" syntastic
let g:syntastic_aggregate_errors = 1
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_warning_symbol='⚠'

" indentLine
let g:indentLine_char = '┆'
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'

" ultisnips (avoiding conflicts with YouCompleteMe)
let g:UltiSnipsExpandTrigger = "<c-b>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

" ctrlp
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
