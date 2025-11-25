" PLUGIN CONFIG

"===========================
" NERDTree
"===========================

nmap <leader>n :NERDTreeFind<cr>
nmap <leader>nc :NERDTreeClose<cr>

" close automatically when open a file for editing
let NERDTreeQuitOnOpen=1


" Start NERDTree when Vim is started without file arguments.

autocmd StdinReadPre * let s:std_in=1

autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" enabling autoreload
autocmd BufEnter NERD_tree_* | execute 'normal R'

au CursorHold * if exists("t:NerdTreeBufName") | call <SNR>15_refreshRoot() | endif

" Enabling Autorefresh for change in the current directory
augroup DIRCHANGE

    au!

    autocmd DirChanged global :NERDTreeCWD

augroup END

" auto close nerdtree when closing vim
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

"let g:NERDTreeLimitedSyntax=1
"let g:NERDTreeHighlightCursorline=0


"===========================
" Autopairs
"===========================

let g:AutoPairsFlyMode = 1
let g:AutoPairsMapBS = 1

" Desactivar en archivos markdown
autocmd FileType markdown let b:AutoPairs = 0

"===========================
" vim-gitgutter
"===========================
" Use fontawesome icons as signs
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '>'
let g:gitgutter_sign_removed = '-'
let g:gitgutter_sign_removed_first_line = '^'
let g:gitgutter_sign_modified_removed = '<'

" Jump between hunks
"nmap <Leader>gn :GitGutterNextHunk<cr> 
"nmap <Leader>gp :GitGutterPrevHunk<cr> 
nmap <Leader>gn <Plug>(GitGutterNextHunk)
nmap <Leader>gp <Plug>(GitGutterPrevHunk)

"===========================
" vim-Airline
"===========================
let g:airline_powerline_fonts=1
