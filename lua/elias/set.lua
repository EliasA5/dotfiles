local set = vim.opt
set.clipboard = "unnamedplus"

set.guicursor = "n-v-c-sm:block,i-ci-ve:ver50,r-cr-o:hor50"

set.number = true
set.relativenumber = true

set.tabstop = 4
set.softtabstop = 0
set.shiftwidth = 0
set.expandtab = true
set.smarttab = true

set.autoindent = true
set.smartindent = true
-- Enable break indent
set.breakindent = true

set.termguicolors = true

set.scrolloff = 8
-- set.signcolumn = "number"

set.hidden = true
set.incsearch = true

set.splitright = true
set.splitbelow = true

-- Save undo history
set.undofile = true

-- Set completeopt to have a better completion experience
set.completeopt = 'menuone,noselect'

-- set termguicolors to enable highlight groups
set.termguicolors = true

local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
    callback = function()
        vim.highlight.on_yank()
    end,
    group = highlight_group,
    pattern = '*',
})

-- add borders to all floating windows
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or "rounded"
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end


