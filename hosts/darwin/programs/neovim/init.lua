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
  highlights = {
    MatchParen = {bg = 'lightblue'},
    MiniTablineCurrent = {fg='fg', bg='bg0', fmt='bold'},
    MiniTablineVisible = {fg='grey', bg='bg1'},
    MiniTablineHidden = {fg='grey', bg='bg1'},
  }
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
vim.cmd([[nnoremap <C-q> :bw<CR>]])


-- Set clipboard to use system clipboard
vim.opt.clipboard = "unnamedplus"

-- TreeSitter
require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true, -- enable syntax highlighting
  }
}

-- Vim Fugitive setup
vim.cmd([[nnoremap <C-g> :0G<CR>]])
vim.cmd([[nnoremap <C-d> :Gdiffsplit<CR>]])

-- CSVview
require('csvview').setup({
  view = {
    display_mode = "border",
  },
})
vim.api.nvim_create_autocmd("FileType", {
  pattern = "csv",
  callback = function()
    vim.cmd("CsvViewEnable")
    vim.opt_local.wrap = false
  end,
})

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
require('mini.sessions').setup({
  autoread = true,
  autowrite = true,
})
require('mini.statusline').setup()
require('mini.tabline').setup()

vim.keymap.set("n", "'", function()
  local buf_name = vim.api.nvim_buf_get_name(0)
  local path = vim.fn.filereadable(buf_name) == 1 and buf_name or vim.fn.getcwd()
  MiniFiles.open(path)
  MiniFiles.reveal_cwd()
end, { desc = "Open Mini Files" })

require('smart-splits').setup({
  default_amount = 1,
  at_edge = 'mux',
})
vim.keymap.set('n', '<D-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<D-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<D-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<D-l>', require('smart-splits').resize_right)
-- moving between splits
vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)

vim.api.nvim_create_autocmd("FileType", {
  pattern = { 'nix', 'lua', 'yaml', 'json', 'lisp' },
  command = "setlocal shiftwidth=2 tabstop=2 softtabstop=2",
  group = augroup,
})

require('fzf-lua').setup({
  fzf_opts = {
    ['--layout'] = 'default', -- search prompt at the bottom
  },
})

vim.cmd([[
nnoremap <space> :FzfLua files<CR>
nnoremap <C-space> :FzfLua live_grep<CR>
]])
