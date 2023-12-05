local set = vim.opt
set.clipboard = "unnamedplus"
vim.api.nvim_exec(
[[
             let g:clipboard = {
         \   'name': 'WslClipboard',
         \   'copy': {
         \      '+': 'clip.exe',
         \      '*': 'clip.exe',
         \    },
         \   'paste': {
         \      '+': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
         \      '*': 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
         \   },
         \   'cache_enabled': 0,
         \ }  
  ]], true)

set.guicursor = ""

set.number = true
set.relativenumber = true

set.tabstop = 4
set.softtabstop = 0
set.shiftwidth = 0
set.expandtab = false
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


