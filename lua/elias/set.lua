local set = vim.opt
set.clipboard = "unnamedplus"

set.guicursor = ""

set.number = true
set.relativenumber = true

set.tabstop = 4
set.softtabstop = 4
set.shiftwidth = 4
set.expandtab = true

set.smartindent = true
-- Enable break indent
vim.o.breakindent = true

set.termguicolors = true

set.scrolloff = 8
-- set.signcolumn = "number"

set.hidden = true
set.incsearch = true

set.splitright = true

-- Save undo history
vim.o.undofile = true

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menuone,noselect'

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})


