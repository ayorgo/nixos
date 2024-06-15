-------------------------------------------------------------------------------
-- Plugins are installed by Nix
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- General settings
-------------------------------------------------------------------------------

-- Fix scrolling slowness https://github.com/vim/vim/issues/2712
vim.cmd([[set re=1]])

-- Have the cursor at the center of the screen at all times
vim.cmd([[set so=999]])

-- Autosave
-- Configure auto-save-nvim plugin so it works
-- which it stopped after the update to NixOS 24.05
require('auto-save').setup({
    enable = true,
    debounce_delay = 10,
})

-- No swap files
vim.cmd([[set noswapfile]])

-- Mouse support
vim.cmd([[set mouse=a]])

-- UTF-8 encoding everywhere
vim.cmd([[set encoding=UTF-8]])

-- Tabs as spaces
vim.cmd([[set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab]])

-- Remove delay when Esc from visual mode
vim.cmd([[set timeoutlen=1000 ttimeoutlen=0]])

-- Search highlight
vim.cmd([[set hlsearch]])
vim.cmd([[set ignorecase]])
vim.cmd([[set smartcase]])

-- Colorscheme
require("catppuccin").setup({
    transparent_background = true
})
vim.cmd.colorscheme "catppuccin"

-- Indentation
vim.cmd([[let g:indentLine_char = '▏']])
vim.cmd([[let g:indentLine_leadingSpaceChar='·']])
vim.cmd([[let g:indentLine_leadingSpaceEnabled='1']])
vim.cmd([[
let g:indentLine_fileTypeExclude = ['json']
]])

vim.cmd([[let g:vim_json_syntax_conceal = 0]])

-- Line numbers
vim.cmd([[set number]])

-- Pane navigation
vim.cmd([[nnoremap <C-h> <C-w>h]])
vim.cmd([[nnoremap <C-j> <C-w>j]])
vim.cmd([[nnoremap <C-k> <C-w>k]])
vim.cmd([[nnoremap <C-l> <C-w>l]])

-- Buffer navigation
vim.cmd([[map <Right> :bnext<CR>]])
vim.cmd([[map <Left> :bprev<CR>]])

-- Ruler
-- vim.cmd([[let &colorcolumn=join(range(81,999), ',')]])

-- Offline edit history
vim.cmd([[set undofile]])
vim.cmd([[set undodir=~/.vim/undo/]])

-- Vertical separator
-- :set fillchars+=vert:│

-- TrueColor support
vim.cmd([[
if (has("termguicolors"))
    set termguicolors
endif]])

-- Spell check
vim.cmd([[:hi SpellBad ctermbg=lightred]])
vim.cmd([[
augroup fileSpell
    autocmd!
    autocmd FileType latex,tex,md,markdown setlocal spell
augroup END]])

-- Delete buffer gracefully
vim.cmd([[
function! DeleteBuffer()
    let total_buffers = len(getbufinfo({'buflisted':1}))
    echo total_buffers
    if total_buffers == 1
        :bd
    else
        :bp
        :bd#
        :AirlineRefresh
    endif
endfunction
nnoremap <C-q> :call DeleteBuffer()<CR>]])

-- Set clipboard to use system clipboard
vim.opt.clipboard = "unnamedplus"

-- NERDtree
vim.cmd([[
autocmd StdinReadPre * let s:std_in=1
au VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
let NERDTreeShowHidden=1
let NERDTreeQuitOnOpen = 0
]])

-- Vim airline
vim.cmd([[
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
let g:airline_section_z='%l:%c'

set noshowmode
]])
