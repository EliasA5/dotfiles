local lsp = require('lsp-zero').preset({
  name = 'recommended',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
vim.keymap.set('n', 'gr', vim.lsp.buf.references)
vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>gf', vim.lsp.buf.code_action)
-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

