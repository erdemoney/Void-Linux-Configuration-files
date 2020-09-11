call plug#begin('$HOME/.config/nvim/plugged')

"Plugins
Plug 'neomake/neomake'

Plug 'scrooloose/nerdtree'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/deoplete-clangx'

Plug 'junegunn/goyo.vim'

Plug 'ap/vim-css-color'

Plug 'godlygeek/tabular'
Plug 'plasticboy/vim-markdown'
Plug 'JamshedVesuna/vim-markdown-preview'

Plug 'reedes/vim-pencil'

Plug 'mhinz/vim-startify'

"LaTeX Plugins
"Plug 'lervag/vimtex'

call plug#end()

let g:airline_theme='minimalist'
let g:airline_focuslost_inactive = 1
let g:airline#extensions#neomake#enabled = 1
let airline#extensions#neomake#error_symbol = 'E:'

" neomake settings
call neomake#configure#automake('nw', 1000)
let g:neomake_place_signs = 1
let g:neomake_cpp_enabled_makers = ['clang']
"let g:neomake_cpp_clang_args = ['-Wall', '-Iinclude', '-Wextra', '-Weverything', '-pedantic', '-Wno-sign-conversion']

" deoplete settings
let g:deoplete#enable_at_startup = 1

let g:deoplete#disable_auto_complete = 0
" deoplete tab-complete
inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

"NERDTree Settings
map <C-n> :NERDTreeToggle<CR>
"close vim if NERDTree is last window open
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
"exclude filetypes
let NERDTreeIgnore = ['\.o$']
"quit NERDTree after selecting file
let NERDTreeQuitOnOpen=1
let NERDTreeNaturalSort = 1
let NERDTreeMinimalUI = 1

"Startify settings
let g:startify_custom_header = [
\ '      ___           ___           ___                                    ___     ',
\ '     /__/\         /  /\         /  /\          ___        ___          /__/\    ',
\ '     \  \:\       /  /:/_       /  /::\        /__/\      /  /\        |  |::\   ',
\ '      \  \:\     /  /:/ /\     /  /:/\:\       \  \:\    /  /:/        |  |:|:\  ',
\ '  _____\__\:\   /  /:/ /:/_   /  /:/  \:\       \  \:\  /__/::\      __|__|:|\:\ ',
\ ' /__/::::::::\ /__/:/ /:/ /\ /__/:/ \__\:\  ___  \__\:\ \__\/\:\__  /__/::::| \:\',
\ ' \  \:\~~\~~\/ \  \:\/:/ /:/ \  \:\ /  /:/ /__/\ |  |:|    \  \:\/\ \  \:\~~\__\/',
\ '  \  \:\  ~~~   \  \::/ /:/   \  \:\  /:/  \  \:\|  |:|     \__\::/  \  \:\      ',
\ '   \  \:\        \  \:\/:/     \  \:\/:/    \  \:\__|:|     /__/:/    \  \:\     ',
\ '    \  \:\        \  \::/       \  \::/      \__\::::/      \__\/      \  \:\    ',
\ '     \__\/         \__\/         \__\/           ~~~~                   \__\/    ',
\ ]

"LaTeX Settings
"let g:tex_flavor  = 'latex'
"let g:tex_conceal = ''
"let g:vimtex_fold_manual = 1
"let g:vimtex_latexmk_continuous = 1
"let g:vimtex_compiler_progname = 'nvr'
"let g:latex_view_general_viewer = "zathura"
"let g:vimtex_view_method = "zathura"

"load ~/.vimrc
"set runtimepath^=~/.vim runtimepath+=~/.vim/after
"let &packpath = &runtimepath
"source ~/.vimrc

"General Vim Settings
set showmatch               " Show matching brackets.
set expandtab               " Insert spaces when TAB is pressed.
set tabstop=4               " Render TABs using this many spaces.
set shiftwidth=4            " Indentation amount for < and > commands.
set title                   " Show current file as window title
set clipboard+=unnamedplus " Set vim clipboard to system clipboard


"Hide mode so its not duplicated in Airline
set noshowmode
"Hide seperator bar in split screen
":set fillchars+=vert:\
hi VertSplit cterm=NONE
