
vim.keymap.set("n", "<leader>fs", vim.cmd.Ex)
vim.keymap.set("n", ":q<CR>", ":NvimTreeClose<CR>:q<CR>")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "<leader>p", "\"_dP")
vim.keymap.set("n", "<leader>d", "\"_d")
vim.keymap.set("v", "<leader>d", "\"_d")


vim.keymap.set("n", "<leader>ss", [[:.,$s/\<<C-r><C-w>\>//gcI<Left><Left><Left><Left>]])
--vim.keymap.set("n", "<leader>x", "<cmd>!chmod u+x %<CR>", { silent = true })

-- vim.keymap.set("n", "<leader><leader>", ":w<CR>:so<CR>:PackerSync<CR>")

vim.keymap.set("n", "<leader>l/", ":noh<CR>", {silent = true})

vim.keymap.set("n", "o", "o<Esc>")
vim.keymap.set("n", "O", "O<Esc>")

vim.keymap.set("n", "<leader>b",  ":ls<CR>:b<space>")


-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

