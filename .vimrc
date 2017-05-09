set nocompatible
filetype off
filetype plugin on

" Bundle management
" ------------------------------------------------------------------------------
if has('nvim')
  call plug#begin('~/.config/nvim/plugged')
else
  call plug#begin('~/.vim/plugged')
endif

" Bundles
Plug 'Shougo/deoplete.nvim'
Plug 'SirVer/ultisnips'
Plug 'Valloric/MatchTagAlways'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'Yggdroot/indentLine'
Plug 'airblade/vim-gitgutter'
Plug 'bling/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'edkolev/tmuxline.vim'
Plug 'gorodinskiy/vim-coloresque'
Plug 'honza/vim-snippets'
Plug 'jiangmiao/auto-pairs'
Plug 'majutsushi/tagbar'
Plug 'mattn/emmet-vim'
Plug 'mfukar/robotframework-vim'
Plug 'mhinz/vim-startify'
Plug 'morhetz/gruvbox'
Plug 'pangloss/vim-javascript'
Plug 'pld-linux/vim-syntax-vcl'
Plug 'rking/ag.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'sheerun/vim-polyglot'
Plug 'terryma/vim-expand-region'
Plug 'terryma/vim-multiple-cursors'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'wakatime/vim-wakatime'
Plug 'zchee/deoplete-jedi'

" Add plugins to &runtimepath
call plug#end()
" ------------------------------------------------------------------------------

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
set relativenumber
set cursorline  " have a line indicate the cursor location
set ruler       " show the cursor position all the time
set wildmenu    " visual autocomplete for command menu
set incsearch   " search as characters are entered
set hlsearch    " highlight matches
set colorcolumn=80 " vertical line at column 80

set wildignore+=*/tmp/*,*/data/*,/log/*,*.so,*.swp,*.zip
set wildignore+=*/parts/*,*/py27/*,*.pyc,*pyo
set wildignore+=*/node_modules/*

" Color scheme
"------------------------------------------------------------------------------
syntax enable
set background=dark
let g:gruvbox_italic=1
colorscheme gruvbox

if has('gui_running')
  set guioptions-=T " remove toolbar
  set guioptions-=m " remove menubar
  set guioptions-=r " remove right-hand scrollbar
  set guioptions-=L " remove left-hand scrollbar
  if has('gui_gtk2')
    set guifont=Ubuntu\ Mono\ derivative\ powerline\ 14
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

" Leader mappings
let mapleader=" "
nnoremap <Leader>w :w<CR>
vmap <Leader>y "+y
nmap <Leader>y "+y
vmap <Leader>d "+d
nmap <Leader>d "+d
nmap <Leader>p "+p
nmap <Leader>P "+P
vmap <Leader>p "+p
vmap <Leader>P "+P

" Reselect visual block after indent visual (@MasteringVim)
vnoremap < <gv
vnoremap > >gv

" Use region expanding
" "(https://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/)
vmap v <Plug>(expand_region_expand)
vmap <C-v> <Plug>(expand_region_shrink)

" Move up/down on wrapped lines
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" sudo write this
cmap W! w !sudo tee % >/dev/null

" sort lines (case sensitive)
vmap <F9> :!LC_COLLATE=C sort<CR>
nmap  <F9> vip:!LC_COLLATE=C sort<CR>

nmap <silent> <F4> :TagbarToggle<CR>
noremap <F3> :NERDTreeToggle<CR>

" Tabs
nnoremap <Tab> gt
nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

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
let g:syntastic_auto_loc_list = 2
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_error_symbol = '✗'
let g:syntastic_style_error_symbol = '✗'
let g:syntastic_style_warning_symbol = '⚠'
let g:syntastic_warning_symbol='⚠'

" indentLine
let g:indentLine_char = '┊'
let g:indentLine_faster = 1

" ultisnips (avoiding conflicts with YouCompleteMe)
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<c-b>"
let g:UltiSnipsJumpBackwardTrigger = "<c-z>"

" ctrlp
let g:ctrlp_user_command = 'ag %s -U -l --nocolor --hidden -g ""'

" deoplete
let g:deoplete#enable_at_startup = 1
" close the preview window after completion is done.
autocmd CompleteDone * pclose!

" Multiple Cursors
function g:Multiple_cursors_before()
  let g:deoplete#disable_auto_complete = 1
endfunction
function g:Multiple_cursors_after()
  let g:deoplete#disable_auto_complete = 0
endfunction

" NERDTree
let NERDTreeIgnore = ['\.pyc$', '\.pyo$']
let NERDTreeShowHidden=1

" Python envs for neovim plugin
let g:python_host_prog = $HOME.'/.pyenv/versions/2.7.13/envs/tools2/bin/python'
let g:python3_host_prog = $HOME.'/.pyenv/versions/3.6.1/envs/tools3/bin/python'
