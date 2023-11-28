
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, { pattern = {"*.norg"}, command = "set conceallevel=3" })


local set = vim.opt_local

set.tabstop = 2
set.softtabstop = 0
set.shiftwidth = 2
set.expandtab = true
set.smarttab = true

