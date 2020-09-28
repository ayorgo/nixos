"
" vim-plug
"
call plug#begin('~/.vim/plugins')
Plug 'preservim/nerdtree'
Plug 'Yggdroot/indentLine'
Plug '907th/vim-auto-save'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary' 
Plug 'tomasiser/vim-code-dark'
call plug#end()

" Fix scrolling slowness https://github.com/vim/vim/issues/2712
set re=1

" Have the cursor at the center of the screen at all times
set so=999

" No swap files
set noswapfile

" Convenient copy/paste
set clipboard=unnamedplus

" UTF-8 encoding everywhere
set encoding=UTF-8

" Autosave as you type
let g:auto_save = 1
let g:auto_save_events = ["CursorHold"]
set updatetime=300
set nobackup nowritebackup " no .swp files

" Tabs as spaces
set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab

" Remove delay when Esc from visual mode
set timeoutlen=1000 ttimeoutlen=0

" Ruler
set colorcolumn=80,100

" Relative line numbers
set number
set relativenumber

" Search highlight
set hlsearch
set ignorecase
set smartcase

" NERDTress File highlighting
" function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
"  exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
"  exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
" endfunction

" NERD Tree
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1

" Syntax highlighting
syntax on
filetype on
let g:python_highlight_all = 1
colorscheme morning

" Indentation
let g:indentLine_char = '▏'
let g:indentLine_leadingSpaceChar='·'
let g:indentLine_leadingSpaceEnabled='1'

" Map Caps to Esc on enter, remap back on exit
au VimEnter * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Escape'
au VimLeave * silent! !xmodmap -e 'clear Lock' -e 'keycode 0x42 = Caps_Lock'

" Pane navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
