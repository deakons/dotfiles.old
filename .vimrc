" Author : Shane Case
" Updated : Jan 2014
" VIM Profile


filetype off
filetype plugin indent on
set encoding=utf-8


set rtp+=~/.vim/bundle/vundle/
call vundle#rc()


" let Vundle manage itself
Bundle 'gmarik/vundle'


" This isn't VI
set nocompatible


" Eliminate security exploit
set modelines=0


" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set ignorecase
set smartcase
set showmatch
set hlsearch
set textwidth=80

if v:version > 703
    set relativenumber
    set undofile
else
    set number
endif


set list
set listchars=tab:▸\ ,eol:¬
set wrap
set textwidth=79
set wm=0
set formatoptions=qt
set t_Co=256
color ir_black
set background=dark
syntax on


" Remove highlighted searches
nnoremap <leader><space> :noh<cr>


" Strip whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>

" Return to position when reopening a file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
