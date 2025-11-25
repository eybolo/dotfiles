" ---------------------------------------------------------------
" => Plugins
" ---------------------------------------------------------------
"
" Instala automaticamente vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

"Syntax highlighting para archivos kitty
Plug 'fladson/vim-kitty'

" Coleccion de paquetes de lenguages
Plug 'sheerun/vim-polyglot'

" TEMA
Plug 'dracula/vim', { 'as': 'dracula' }

" Status bar and themes
Plug 'vim-airline/vim-airline'

" Cierra automaticamente parentesis, corchetes, llaves, etc.
Plug 'jiangmiao/auto-pairs'

" Explorador de archivos
Plug 'preservim/NERDTree'

" Muestra líneas añadidas, modificadas o eliminadas según Git
Plug 'airblade/vim-gitgutter'

call plug#end()
