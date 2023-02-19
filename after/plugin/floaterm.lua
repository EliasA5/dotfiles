vim.g.floaterm_width = 0.95
vim.g.floaterm_height = 0.95
vim.keymap.set('n', '<leader>gs', ':FloatermNew lazygit<CR>')

vim.keymap.set('n', '<C-t>', ':FloatermToggle term<CR>')
vim.keymap.set('n', '<M-t>', ':FloatermKill term<CR>')
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:FloatermToggle term<CR>', { silent = true } )



