" Author : Shane Case
" Updated : Jan 2014
" VIM Profile


filetype off
filetype plugin indent on
set encoding=utf-8


set rtp+=~/.vim/bundle/Vundle.vim/
call vundle#rc()


" let Vundle manage itself
Bundle 'gmarik/vundle'
Bundle 'altercation/vim-colors-solarized'
Bundle 'ntpeters/vim-better-whitespace'
Bundle 'itchyny/calendar.vim'
Bundle 'bling/vim-airline'
Bundle 'majutsushi/tagbar'
Bundle 'mhinz/vim-startify'


" This isn't VI
set nocompatible


" Eliminate security exploit
set modelines=0


" Tabs
set tabstop=4
set shiftwidth=4
set softtabstop=4
set expandtab


"set showmode
"set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set cursorline
set ttyfast
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber
set undofile
set ignorecase
set smartcase
set showmatch
set hlsearch
set textwidth=80


set list
set listchars=tab:▸\ ,eol:¬
set wrap
set textwidth=79
set wm=0
set formatoptions=qt
set t_Co=256
color ir_black
set background=dark
"colorscheme solarized
"color solarized
syntax on
set foldmethod=syntax

let g:airline#extensions#tabline#enabled = 1
let g:airline_section_b = '%{strftime("%c")}'


" Remove highlighted searches
nnoremap <leader><space> :noh<cr>
"
nmap <F8> :TagbarToggle<CR>

" Strip whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<CR>


nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <Space> zf

" Return to position when reopening a file
autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
