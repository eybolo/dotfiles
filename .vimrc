" ---------------------------------------------------------------
" => Config
" ---------------------------------------------------------------

" disable Vi compatibility
set nocompatible

" Add numbers to the file.
set number

" change column width for number
set numberwidth=1

" Enable Mouse
set mouse=a

" Número de líneas alrededor del cursor al desplazarse
set scrolloff=10

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

" No hacer backup
set nobackup

"Desactivar swap file 
set noswapfile

"Recarga automatic archivos cambiado fuera de vim
set autoread

"Muestra caracteres de espacio en blanco y tabuladores
set list

"Resalta la columna 100
set colorcolumn=100

"Ancho de texto a 100 caracteres
set textwidth=100

" Habilitar la indentación automática
set autoindent

" Habilitar la indentación inteligente
set smartindent

" Set color scheme
set termguicolors

" ---------------------------------------------------------------
" => Mapping 
" ---------------------------------------------------------------

noremap <SPACE> <Nop>

" Set the SPACE as the leader key.
inoremap jj <esc>

" Set the backslash as the leader key.
let mapleader = ' '

nmap <leader>w :w<cr>
nmap <leader>q :q<cr>

" ---------------------------------------------------------------
" => Config Plugins 
" ---------------------------------------------------------------

so ~/.vim/plugins.vim
so ~/.vim/plugin-config.vim

colorscheme dracula 
