" Author : Shane Case
" Updated : Sept 2016
" VIM Profile

set nocompatible		" This isn't Vi.
filetype off
set encoding=utf-8


set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()


" let Vundle manage itself
Plugin 'VundleVim/Vundle.vim'
Plugin 'ntpeters/vim-better-whitespace'
Plugin 'majutsushi/tagbar'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'tpope/vim-fugitive'
Plugin 'scrooloose/syntastic'
Plugin 'scrooloose/nerdtree'
Plugin 'xuyuanp/nerdtree-git-plugin'

call vundle#end()

filetype plugin on
filetype indent on

" Eliminate security exploit
set modelines=0

" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab

"set showmode
"set showcmd
set background=dark
syntax on
set hidden
set wildmenu
set wildmode=list:longest
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile
set ignorecase
set smartcase
set showmatch
set mat=2
set nobackup
set nowb
set noswapfile
set smarttab
set hlsearch
set incsearch
set textwidth=80


set list
set listchars=tab:▸\ ,trail:•,extends:»,precedes:«,eol:¬ " Unprintable chars mapping
set wrap
set textwidth=79
set wm=0
set formatoptions=qt
set t_Co=256
"color ir_black

let g:airline#extensions#tabline#enabled = 1
let g:airline_theme='luna'

autocmd vimenter * NERDTree
autocmd vimenter * wincmd p

autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Remove highlighted searches
nnoremap <leader><space> :noh<cr>
"
nmap <F8> :TagbarToggle<CR>

vnoremap <Space> zf

" Return to position when reopening a file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif

