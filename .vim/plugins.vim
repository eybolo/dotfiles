" ---------------------------------------------------------------
" => Plugins
" ---------------------------------------------------------------

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')


Plug 'fladson/vim-kitty'
" Colection of language packs
Plug 'sheerun/vim-polyglot'

Plug 'neoclide/coc.nvim', {'branch':'release'}

" Status bar and themes
Plug 'vim-airline/vim-airline'
"Plug 'itchyny/lightline.vim'
"Plug 'josa42/vim-lightline-coc'
"Plug 'vim-airline/vim-airline-themes'

Plug 'yggdroot/indentline'

Plug 'jiangmiao/auto-pairs'
"Plug 'powerline/powerline'

"Plug 'dense-analysis/ale'
Plug 'preservim/NERDTree'
" Plug 'christoomey/vim-tmux-navigator',

Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'morhetz/gruvbox'
Plug 'mhinz/vim-signify'

" Parentheses, brackets, quotes
Plug 'tpope/vim-surround'
"jPlug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'wfxr/minimap.vim'
Plug 'luochen1990/rainbow'
call plug#end()
