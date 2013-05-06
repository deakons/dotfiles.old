" .vimrc -- VIM configuration file
" Author: Shane Case
"

" Set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8

" Disable vi compatibilty
set nocompatible

" Use indentation of previous line
set autoindent

" Syntax highlighting
set t_Co=256
colors peaksea
set background=dark
syntax on	
filetype on
filetype plugin on
filetype indent on

" Line Numbers	
set number

" Show what mode we are in
set showmode

" Reload if changed outside vim
set autoread

" Force show a status line
set laststatus=2 

" Ignore case when searching
set ignorecase

" If we type case sensitive then search case sensitive
set smartcase

" Show matching braces
set showmatch

" Set the terminal title
set title

" Format the status line
set stl=%f\ %m\ %r\ Line:\ %l/%L[%p%%]\ Col:\ %c\ 
set cmdheight=2

" Wrap lines at 80 characters
set textwidth=80

" File completion
set wildmenu
set wildmode=list:longest,full

" Ctags
set tags+=./tags

"
" Keyboard bindings
"
" Save file in command mode
nmap <F2> :w<CR>

" Insert move exit, save, reenter insert
map <F2> <ESC>:w<CR>i

" Regen ctags
map <F5> :!ctags -R --c++-kings=+p --fields=+iaS --extra+q .<CR>

" Compile
nmap <F7> :make<CR>

map <F12> <C-]>
