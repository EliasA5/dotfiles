local lsp = require('lsp-zero').preset({
  name = 'recommended',
  set_lsp_keymaps = true,
  manage_nvim_cmp = true,
  suggest_lsp_servers = false,
})

-- configured in telescope
-- vim.keymap.set('n', 'gD', vim.lsp.buf.declaration)
-- vim.keymap.set('n', 'gd', vim.lsp.buf.definition)
-- vim.keymap.set('n', 'gr', vim.lsp.buf.references)
-- vim.keymap.set('n', '<leader>gi', vim.lsp.buf.implementation)
vim.keymap.set('n', '<leader>gf', vim.lsp.buf.code_action, {desc = "LSP code action"})
-- (Optional) Configure lua language server for neovim
lsp.nvim_workspace()

lsp.setup()

vim.keymap.set('n', '<leader>tt', '<cmd>Telescope diagnostics<CR>', { desc = "LSP Diagnostics", noremap = true, silent = true })
vim.keymap.set('n', '<leader>tl', vim.diagnostic.open_float, { desc = "Open diagnostic float", noremap = true, silent = true })
vim.keymap.set("n", "<leader>rr", vim.lsp.buf.rename, {desc = "Rename symbol under cursor"})

local cmp = require('cmp')

cmp.setup({
  mapping = {
      ['<CR>'] = cmp.mapping.confirm({select = true}),
  }
})

local virtual_text = false
vim.diagnostic.config({ virtual_text = virtual_text, })
vim.keymap.set('n', '<leader>tv', function()
    virtual_text = not virtual_text
    vim.diagnostic.config({ virtual_text = virtual_text, })
end, { desc = "Toggle diagnostic virtual text", })


