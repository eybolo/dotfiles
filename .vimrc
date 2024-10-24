" ---------------------------------------------------------------
" => Config
" ---------------------------------------------------------------
"python3 from powerline.vim import setup as powerline_setup
"python3 powerline_setup()
"python3 del powerline_setup
" disable Vi compatibility
set nocompatible

" Add numbers to the file.
set number

" change column width for number
set numberwidth=1

" Enable Mouse
set mouse=a

" Enable clipboard system
set clipboard=unnamedplus

" syntax highlighting on.
syntax on

"show command in last line of the screen
set showcmd

" Show cursor position below each window
set ruler 

" Encondig
set encoding=utf-8

" matching parenthesis
set showmatch


set relativenumber

" Number of spaces a <Tab> in the text stands for
set tabstop=4		
set shiftwidth=4	
set softtabstop=4
set expandtab

"Displaying status line always
set laststatus=2

" Highlight the screen line of the cursor
set cursorline
set cursorcolumn

" ignore capital letters during search.
set ignorecase

" Use highlighting when doing a search.
set hlsearch

" While searching though a file incrementally highlight matching characters as
" you type
set incsearch

" Show cursor position below each window
set history=1000

" Background color brightness
set background=dark

"Enable 256 colours
set t_Co=256

" ---------------------------------------------------------------
" => Mapping 
" ---------------------------------------------------------------


nnoremap <SPACE> <Nop>

" Set the SPACE as the leader key.
inoremap jj <esc>

" Set the backslash as the leader key.
let mapleader = ' '

nmap <leader>w :w<cr>
nmap <leader>q :q<cr>

so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim

"set guifont=DroidSansMono\ Nerd\ Font\ 11 
" ---------------------------------------------------------------
" => Config Plugins 
" ---------------------------------------------------------------

"let g:airline_theme='powerlineish'
"let g:airline_theme='molokai'
let g:airline_powerline_fonts=1


" gruvbox
"let g:gruvbox_contrast_dark = "hard"

" Set color scheme
colorscheme dracula 
set termguicolors
