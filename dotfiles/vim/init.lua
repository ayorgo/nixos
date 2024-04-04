-- VIM-PLUG
local data_dir = vim.fn.has('nvim') == 1 and vim.fn.stdpath('data') .. '/site' or '~/.vim'
if vim.fn.empty(vim.fn.glob(data_dir .. '/autoload/plug.vim')) == 1 then
  vim.fn.system('curl -fLo ' .. data_dir .. '/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim')
  vim.api.nvim_create_autocmd("VimEnter", {
    pattern = "*",
    command = "PlugInstall --sync | source $MYVIMRC",
  })
end

vim.call('plug#begin', '~/.vim/plugins')

-- Comment stuff out. Use gcc to comment out a line (takes a count), gc to
-- comment out the target of a motion (for example, gcap to comment out a
-- paragraph), gc in visual mode to comment out the selection, and gc in
-- operator pending mode to target a comment.
vim.call('plug#', 'tpope/vim-commentary')

-- Neovim colorscheme using Gnome Adwaita syntax
vim.call('plug#', 'Mofiqul/adwaita.nvim')

vim.call('plug#', 'Pocco81/auto-save.nvim')

vim.call('plug#end')

vim.o.background = "dark"
vim.g.adwaita_darker = true -- for darker version
vim.g.adwaita_disable_cursorline = false -- to disable cursorline
-- vim.g.adwaita_transparent = true -- makes the background transparent
vim.cmd([[colorscheme adwaita]])

-- Set clipboard to use system clipboard
vim.opt.clipboard = "unnamedplus"
