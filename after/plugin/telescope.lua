local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Fuzzy find files"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Live grep inside files"})
vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "Search in files indexed by git"})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {desc = "Search for word under cursor"})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {desc = "LSP Defnition"})
vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, {desc = "LSP Type Definition"})
vim.keymap.set('n', 'gr', builtin.lsp_references, {desc = "LSP References"})


