local actions = require("telescope.actions")
require("telescope").setup {
    pickers = {
        find_files = {
            mappings = {
                i = {
                    ["<C-j>"] = {
                        actions.move_selection_next, type = "action",
                        opts = { nowait = true, silent = true }
                    },
                    ["<C-k>"] = {
                        actions.move_selection_previous, type = "action",
                        opts = { nowait = true, silent = true }
                    },
                    ["<C-p>"] = false,
                    ["<C-n>"] = false,
                },
            },
        },
    },
}

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Fuzzy find files"})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Live grep inside files"})
vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "Search in files indexed by git"})
vim.keymap.set('n', '<leader>fw', builtin.grep_string, {desc = "Search for word under cursor"})
vim.keymap.set('n', 'gd', builtin.lsp_definitions, {desc = "LSP Defnition"})
vim.keymap.set('n', 'gD', builtin.lsp_type_definitions, {desc = "LSP Type Definition"})
vim.keymap.set('n', 'gr', builtin.lsp_references, {desc = "LSP References"})
vim.keymap.set('n', 'gb', builtin.buffers, {desc = "Goto buffers"})
vim.keymap.set('n', '<leader>fc', builtin.lsp_incoming_calls, {desc = "Fuzzy find function calls"})


