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

-- Rounded border around floating (pop-up) windows
vim.o.winborder = "rounded"

-- Indentation
vim.cmd([[set list]])
vim.cmd([[set listchars=lead:·,trail:·,tab:->\ ]])

require("ibl").setup {
  indent = { char = "│" },
  scope = { enabled = false },
}

-- Line numbers
vim.cmd([[set number]])

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

-- Set clipboard to use system clipboard
vim.opt.clipboard = "unnamedplus"

---------------
-- Key mappings
---------------
-- Map leader key to space
vim.g.mapleader = " "

-- barbar: buffer navigation and management
vim.keymap.set('n', '<Right>', ':BufferNext<CR>')
vim.keymap.set('n', '<Left>', ':BufferPrevious<CR>')
vim.keymap.set('n', '<C-Right>', ':BufferMoveNext<CR>')
vim.keymap.set('n', '<C-Left>', ':BufferMovePrevious<CR>')
vim.keymap.set('n', '<C-q>', ':BufferClose<CR>')
vim.keymap.set('n', '<S-x>', ':BufferRestore<CR>')
vim.keymap.set('n', '<C-p>', ':BufferPick<CR>')

-- smart-splits: resizing
vim.keymap.set('n', '<A-h>', ':SmartResizeLeft<CR>')
vim.keymap.set('n', '<A-j>', ':SmartResizeDown<CR>')
vim.keymap.set('n', '<A-k>', ':SmartResizeUp<CR>')
vim.keymap.set('n', '<A-l>', ':SmartResizeRight<CR>')

-- smart-splits: moving between splits
vim.keymap.set('n', '<C-h>', ':SmartCursorMoveLeft<CR>')
vim.keymap.set('n', '<C-j>', ':SmartCursorMoveDown<CR>')
vim.keymap.set('n', '<C-k>', ':SmartCursorMoveUp<CR>')
vim.keymap.set('n', '<C-l>', ':SmartCursorMoveRight<CR>')

-- Vim Fugitive
vim.keymap.set('n', '<leader>gg', ':0G<CR>')
vim.keymap.set('n', '<leader>gd', ':Gvdiffsplit<CR>')
vim.keymap.set('n', '<leader>gb', ':Git blame<CR>')
vim.keymap.set('n', '<leader>gbr', ':GBrowse!<CR>')
vim.keymap.set('v', '<leader>gbr', ":'<,'>GBrowse!<CR>")

-- fzf-lua
vim.keymap.set('n', '<leader>ff', ':FzfLua files<CR>')
vim.keymap.set('n', '<leader>ft', ':FzfLua live_grep<CR>')
vim.keymap.set('n', '<leader>fb', ':FzfLua buffers<CR>')
vim.keymap.set('n', '<leader>fc', ':FzfLua command_history<CR>')

-- Folding
vim.keymap.set("n", "<Tab>", "za")

-- Pasting in command mode
vim.keymap.set('c', '<C-v>', '<C-r>+')


-- Colorscheme
require('onedark').setup({
  transparent = true,
  style = 'warm',
  highlights = {
    MatchParen = {bg = 'lightblue'},
    -- barbar settings
    BufferCurrent = {fg='fg', bg='bg0', fmt='bold'},
    BufferVisible = {fg='grey', bg='bg1'},
    BufferInactive = {fg='grey', bg='bg1'},

    -- Floating window styling
    FloatBorder = { bg = "none", fg='fg', fmt='bold' },
    NormalFloat = { bg = "none" },
  }
})
vim.cmd.colorscheme "onedark"

-- mini.files
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
      ["csv"] = true,  -- in favour of csvview.nvim
      ["tsv"] = true,  -- in favour of csvview.nvim
      ["csvview-info"] = true,  -- in favour of csvview.nvim
      ["man"] = true,
      ["rust"] = true,
    }
    if disabled[vim.bo.filetype] then
      return
    end
    vim.treesitter.start()
  end,
})

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

require('mini.statusline').setup()
require('mini.icons').setup()
require('mini.files').setup({
  mappings = {
    close       = '<ESC>',
    go_in       = '<Right>',
    go_in_plus  = '<CR>',
    go_out      = '<Left>',
    go_out_plus = 'H',
    reset       = '<BS>',
    reveal_cwd  = '@',
    show_help   = 'g?',
    synchronize = "'",
    trim_left   = '<',
    trim_right  = '>',
  },
})

-- barbar integration with mini.sessions
vim.opt.sessionoptions:append 'globals'
require('mini.sessions').setup({
  autoread = true,
  autowrite = true,

  -- barbar integration
  hooks = {
    pre = {
      write = function() vim.api.nvim_exec_autocmds('User', {pattern = 'SessionSavePre'}) end,
    },
  },
})
require('barbar').setup({
  clickable = false,
  animation = false,
  maximum_length = 80,
  minimum_length = 5,
  maximum_padding = 1,
  minimum_padding = 1,
  icons = {
    button = '',
    filetype = {
      enabled = true,
      custom_colors = false,
    },
    inactive = {button = '', separator = { left = '', right = '' }},
    separator = {left = '', right = ''},
    separator_at_end = false,
    modified = {button = ''},
  },
})

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
    on_create = function(e)
      vim.keymap.set('t', '<c-V>', function()
        vim.api.nvim_paste(vim.fn.getreg('+'), false, -1)
      end, { buffer = e.bufnr })
    end
  },
  files = {
    -- Need to repeat the same options from fd.nix and fzf.nix all over again.
    cmd = "fd --type f --type l --no-ignore --hidden --exclude .git --exclude .venv_default",
    fzf_opts = {
      ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-files-history',
    },
  },
  grep = {
    cmd = "rg --multiline --column --line-number --color=always --smart-case --no-heading --no-ignore --hidden --glob '!.git' --glob '!.venv_default' --max-columns=4096 -e",
    fzf_opts = {
      ['--history'] = vim.fn.stdpath("data") .. '/fzf-lua-grep-history',
    },
  },
})

-- Folding
vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevel = 99
vim.opt.foldlevelstart = 99

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
vim.lsp.enable("ty")
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local opts = { buffer = args.buf }
    -- https://neovim.io/doc/user/lsp.html#lsp-defaults
    -- "grr" is mapped to vim.lsp.buf.references()
    -- "grt" is mapped to vim.lsp.buf.type_definition()
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "grn", function() vim.lsp.buf.rename() vim.cmd("silent! wa") end, opts)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client.name == "ty" then
      client.server_capabilities.semanticTokensProvider = nil
    end
    if client:supports_method('textDocument/foldingRange') then
      local win = vim.api.nvim_get_current_win()
      vim.wo[win][0].foldexpr = 'v:lua.vim.lsp.foldexpr()'
    end
  end,
})

vim.diagnostic.config{
    virtual_lines = false,
    virtual_text = false,
}
vim.opt.updatetime = 300
vim.cmd([[autocmd CursorHold * lua vim.diagnostic.open_float(nil, {scope="cursor", header="", focusable=false})]])

-- Display dadbod results as csv
vim.filetype.add({
  extension = {
    dbout = "csv",
  },
})

-- Rust LSP
vim.lsp.config("rust-analyzer", {
	cmd = { "rust-analyzer" },
	filetypes = { "rust" },
})
vim.lsp.enable("rust-analyzer")
