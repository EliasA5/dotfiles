
vim.api.nvim_create_autocmd({"BufEnter", "BufWinEnter"}, { pattern = {"*.norg"}, command = "set conceallevel=3" })

vim.keymap.set(
  "n", "<leader>nb",
  "<cmd>Neorg keybind all core.looking-glass.magnify-code-block<cr>",
  { noremap = true, desc = "Edit code block in a separate buffer"}
)

local set = vim.opt_local

set.tabstop = 2
set.softtabstop = 0
set.shiftwidth = 2
set.expandtab = true
set.smarttab = true

vim.cmd("set noswapfile")

