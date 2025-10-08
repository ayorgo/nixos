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

-- Cursor line
vim.cmd([[set cursorline]])

-- Tabs as spaces
vim.cmd([[set tabstop=8 softtabstop=0 expandtab shiftwidth=4 smarttab]])

-- Remove delay when Esc from visual mode
vim.cmd([[set timeoutlen=1000 ttimeoutlen=0]])

-- Search highlight
vim.cmd([[set hlsearch]])
vim.cmd([[set ignorecase]])
vim.cmd([[set smartcase]])

-- Colorscheme
require('onedark').setup({
    transparent = true,
    style = 'warm',
})
vim.cmd.colorscheme "onedark"


-- Indentation
vim.cmd([[set list]])
vim.cmd([[set listchars=lead:·,trail:·,tab:->\ ]])

require("ibl").setup {
    indent = { char = "│" },
    scope = { enabled = false },
}

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
vim.cmd([[set undodir=~/.config/nvim/undo/]])

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
-- If there's a Gitsigns diff buffer anywhere, close it first
vim.cmd([[
function! DeleteBuffer()
    let gitsigns_diff_buffer_name = bufname('gitsigns')
    let total_buffers = len(getbufinfo({'buflisted':1}))
    if !empty(gitsigns_diff_buffer_name)
        let gitsigns_diff_buffer_number = bufnr(gitsigns_diff_buffer_name)
        execute 'bd ' . gitsigns_diff_buffer_number
    elseif total_buffers == 1
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

-- TreeSitter
require 'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true, -- enable syntax highlighting
    }
}

-- Vim airline
vim.cmd([[
" Enable tabline for vim-airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 0
if !exists('g:airline_symbols')
      let g:airline_symbols = {}
endif
let g:airline_symbols.space = "\ua0"

let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_section_z='%l:%c'

set noshowmode
]])

-- FZF shortcuts
vim.cmd([[
nnoremap <space> :FZF<CR>
nnoremap <C-space> :RG<CR>
]])

-- Gitsigns setup
require('gitsigns').setup()
vim.cmd([[
nnoremap <C-d> :Gitsigns diffthis split=aboveleft vertical=true<CR>
]])

-- CSVview
require('csvview').setup()

require('ccc').setup({
    highlighter = {
        auto_enable = true,
        lsp = true,
    },
})

require('mini.icons').setup()
require('mini.files').setup({
  mappings = {
    close       = '<ESC>',
    go_in       = 'l',
    go_in_plus  = '<CR>',  -- changed from L
    go_out      = 'h',
    go_out_plus = 'H',
    reset       = '<BS>',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = "'",
    trim_left   = '<',
    trim_right  = '>',
  },
})

vim.keymap.set("n", "'", function()
      local buf_name = vim.api.nvim_buf_get_name(0)
      local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
      MiniFiles.open(path)
      MiniFiles.reveal_cwd()
    end, { desc = "Open Mini Files" })

-- require('hop').setup()
-- vim.api.nvim_set_keymap('n', '<space>', '<cmd>HopWord<cr>', { noremap = true, silent = true })
