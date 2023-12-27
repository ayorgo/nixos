"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" VIM-PLUG
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugins')


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Display directory tree on the left hand side
Plug 'preservim/nerdtree'

autocmd StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen = 0

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" This plugin is used for displaying thin vertical lines at each indentation
" level for code indented with spaces.
Plug 'Yggdroot/indentLine'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" AutoSave - automatically saves changes to disk without having to use :w (or
" any binding to it)
Plug '907th/vim-auto-save'

let g:auto_save = 1
let g:auto_save_events = ["CursorHold"]
set updatetime=300
set nobackup nowritebackup " no .swp files

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"Surround.vim is all about 'surroundings': parentheses, brackets, quotes, XML
"tags, and more. The plugin provides mappings to easily delete, change and add
"such surroundings in pairs.
Plug 'tpope/vim-surround'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Comment stuff out. Use gcc to comment out a line (takes a count), gc to
" comment out the target of a motion (for example, gcap to comment out a
" paragraph), gc in visual mode to comment out the selection, and gc in
" operator pending mode to target a comment.
Plug 'tpope/vim-commentary'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A Vim plugin which shows a git diff in the sign column.
Plug 'airblade/vim-gitgutter'

highlight clear SignColumn

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" A Vim plugin to colorize all text in the form #rgb, #rgba, #rrggbb,
" #rrgbbaa, rgb(...), rgba(...).
Plug 'lilydjwg/colorizer'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Light and dark vim colorscheme, shamelessly stolen from atom.
Plug 'rakr/vim-one'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim port of FZF
Plug 'junegunn/fzf.vim'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Lean & mean status/tabline for vim that's light as air.
Plug 'vim-airline/vim-airline'

" Enable tabline for vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

nnoremap <C-n>   :bnext<CR>
nnoremap <C-s>   :bp\|bd #<CR>

let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_z=''

set noshowmode

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" GitHub Copilot.
Plug 'github/copilot.vim'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Vim port of emacs-which-key.
Plug 'liuchengxu/vim-which-key'

"nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" CSV highlighting
Plug 'mechatroner/rainbow_csv'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Catppuccin theme
Plug 'catppuccin/vim', { 'as': 'catppuccin' }

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
call plug#end()

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Fix scrolling slowness https://github.com/vim/vim/issues/2712
set re=1

" Have the cursor at the center of the screen at all times
set so=999

" No swap files
set noswapfile

" Mouse support
set mouse=a

" Convenient copy/paste. Requires +clipboard option in viw --version
set clipboard=unnamedplus

" UTF-8 encoding everywhere
set encoding=UTF-8

" Tabs as spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Remove delay when Esc from visual mode
set timeoutlen=1000 ttimeoutlen=0

" Relative line numbers
set number

" Search highlight
set hlsearch
set ignorecase
set smartcase

" Syntax highlighting
syntax on
filetype on
let g:python_highlight_all = 1

" Colorscheme
colorscheme catppuccin_mocha
" colorscheme one
" set background=dark " for the dark version
" set background=light " for the light version

" Indentation
let g:indentLine_char = '▏'
let g:indentLine_leadingSpaceChar='·'
let g:indentLine_leadingSpaceEnabled='1'
let g:indentLine_fileTypeExclude = ['json']

let g:vim_json_syntax_conceal = 0

" Pane navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
map <Right> :bnext<CR>
map <Left> :bprev<CR>

" Ruler
" set colorcolumn=80
" highlight ColorColumn ctermbg=7

" Offline edit history
set undofile
set undodir=~/.vim/undo/

" Vertical separator
:set fillchars+=vert:│

" Run python scripts
autocmd FileType python nnoremap <buffer> <C-enter> :!clear;docker run --gpus all -v %:p:h:/home/ayorgo/code/ python:3.10-pytorch-cuda-ayorgo python %:t<CR>

" Run python black formatter
function! PythonFormat()
    let save_pos = getpos(".") " save cursor position
    silent %!isort - -q
    silent %!black - -q
    call setpos('.', save_pos) " set cursor back to saved position
endfunction

autocmd FileType python nnoremap <buffer> <C-Space> :call PythonFormat()<CR>

" Spell check
:hi SpellBad ctermbg=lightred

augroup fileSpell
    autocmd!
    autocmd FileType latex,tex,md,markdown setlocal spell
augroup END
