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
vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    disabled = {
      ["minifiles"] = true,
      ["fzf"] = true,
      ["qf"] = true,
      ["fugitive"] = true,
      ["fugitiveblame"] = true,
      ["git"] = true,
      ["dbout"] = true,
      ["text"] = true,
    }
    if disabled[vim.bo.filetype] then
      return
    end
    vim.treesitter.start()
  end,
})

-- Vim Fugitive setup
vim.cmd([[nnoremap <C-g> :0G<CR>]])
vim.cmd([[nnoremap <C-d> :Gvdiffsplit<CR>]])

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

vim.keymap.set("n", "<C-,>", function()
  print("Left!")
end, { desc = "Move Tab Left" })

vim.keymap.set("n", "<C-.>", function()
  print("Right!")
end, { desc = "Move Tab Left" })

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
vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
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
  winopts = {
    width = 1.0,
  },
  grep = {
    rg_opts = '--multiline --column --line-number --no-heading --color=always --smart-case --max-columns=4096 -e',
  },
})

vim.cmd([[
nnoremap <space> :FzfLua files<CR>
nnoremap <C-space> :FzfLua live_grep<CR>
]])

-- Folding
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99
vim.keymap.set("n", "<Tab>", "za")

-- vim.lsp.config('pyright', {
--   cmd = { 'pyright-langserver', '--stdio' },
--   filetypes = { 'python' },
--   root_markers = { '.git' },
--   settings = {
--     python = {
--       pythonVersion = "3.11",  -- doesn't seem to work
--       venvPath = vim.fn.getcwd(),
--       venv = "venv_default",
--       analysis = {
--         useLibraryCodeForTypes = false,  -- doesn't seem to work
--         -- pythonPath = vim.fn.getcwd() .. "/.venv_default/bin/python", -- https://github.com/astral-sh/uv/issues/6782
--         extraPaths = {
--           -- vim.fn.getcwd() .. "/python-site-packages",
--           vim.fn.getcwd() .. "/.venv_default/lib/python3.11/site-packages",
--         },
--         typeCheckingMode = "standard",
--         diagnosticMode = "openFilesOnly",
--         autoSearchPaths = true,
--         diagnosticSeverityOverrides = {
--           reportMissingImports = false,
--           reportAttributeAccessIssue = false,
--           reportMissingTypeStubs = false,
--           reportGeneralTypeIssues = false,
--           reportCallIssue = false,
--           reportArgumentType = false,
--         },
--       },
--     },
--   },
-- })
-- vim.lsp.enable('pyright')
vim.lsp.config('ty', {
  cmd = { 'ty', 'server' },
  filetypes = { 'python' },
  root_markers = { '.git' },
  settings = {
    ty = {
      diagnosticMode = "openFilesOnly",
      configuration = {
        environment = {
          ["python-version"] = "3.11",
          -- For Docker container Python packages exposed to the host via e.g.:
          -- ```
          -- docker cp <container-name>:/home/vscode/.local/lib/python3.11/site-packages python-site-packages
          -- ```
          -- This mitigates version conflicts between Python packages from different projects on the host
          -- while also avoiding the hassle of installing Neovim inside a container, copying its config
          -- and plugins over, running it in server mode, and then attaching a host Neovim instance as client.
          -- I.e. essentially what VSCode does with its devcontainers.
          -- Sure this doesn't expose the container environment in its entirety missing:
          -- * environment variables
          -- * applications, such as: formatters, linters, or cloud clients.
          -- but I don't think a text editor should replace the terminal when it comes to
          -- running commands either inside containers or on the host.
          -- Tools like LSPs, linters, and formatters can live on the host without issue.
          ["extra-paths"] = {
            vim.fn.getcwd() .. "/.venv_default/lib/python3.11/site-packages",
          },
        },
      },
    },
  },
})
vim.lsp.enable('ty')
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(ev)
    local opts = { buffer = ev.buf }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
  end,
})

vim.diagnostic.config{
    virtual_lines = { current_line = true, },  -- floating text displayed on line below current line
}

-- Display dadbod results as csv
vim.filetype.add({
  extension = {
    dbout = "csv",
  },
})
