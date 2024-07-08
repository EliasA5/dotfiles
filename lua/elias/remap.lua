
vim.keymap.set("n", "<leader>fs", ":Oil<CR>", {desc = "Open filesystem", silent = true, })
vim.keymap.set("n", "-", ":Oil<CR>", { silent = true, })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")
vim.keymap.set("n", "<leader>a", ":keepjumps normal! ggVG<cr>")

vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

vim.keymap.set("x", "p", "P")
vim.keymap.set("x", "P", "p")
vim.keymap.set("n", "gP", "`[v`]", {desc = "select pasted text"})
vim.keymap.set({"n", "v"}, "<leader>d", "\"_d")
vim.keymap.set({"n", "x"}, "x", "\"_x")

vim.keymap.set("n", "<leader>rs", [[:%s/\<<C-r><C-w>\>//gcI<Left><Left><Left><Left>]], {desc = "Search and Replace word under cursor"})
vim.keymap.set("n", "<leader>rl", [[:%s/<C-r><C-w>//gcI<Left><Left><Left><Left>]], {desc = "Loosely Search and Replace word under cursor"})

vim.keymap.set("n", "<leader>/", ":noh<CR>", {desc = "Remove highlight", silent = true, })

vim.keymap.set("n", "o", "o<Esc>")
vim.keymap.set("n", "O", "O<Esc>")

-- Remap for dealing with word wrap
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true, })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true, })

vim.keymap.set("n", "<C-Left>", "4<C-w><")
vim.keymap.set("n", "<C-Right>", "4<C-w>>")
vim.keymap.set("n", "<C-Up>", "4<C-w>+")
vim.keymap.set("n", "<C-Down>", "4<C-w>-")

-- split horizontally
vim.keymap.set("n", "<C-w>h", "<C-w>s")

vim.keymap.set("n", "<leader>gx",
function()
  local path = vim.api.nvim_buf_get_name(0)
  print(path)
  vim.fn.setreg('+', path)
  return path
end , { desc = "copy full path to clipboard", })

vim.keymap.set("n", "<leader>gc",
function()
  local path = vim.fn.expand("%:.")
  print(path)
  vim.fn.setreg('+', path)
  return path
end , { desc = "copy relative to clipboard", })

-- vim.keymap.set("n", "<leader><leader>", ":w<CR>:so<CR>")
vim.keymap.set("n", "gw", ":%s/\\s\\+$//e<CR>", { desc = "Remove trailing white spaces", })

vim.keymap.set("n", "<leader>ts", ":set invlist<CR>", { desc = "show tabs", silent = true, })

vim.keymap.set("n", "i", function()
  if #vim.fn.getline(".") == 0 then
    return [["_cc]]
  else
    return "i"
  end
end, { expr = true, desc = "properly indent on empty line when insert" })

vim.keymap.set("n", "dd", function()
  if vim.api.nvim_get_current_line():match("^%s*$") then
      return '"_dd'
  else
      return "dd"
  end
end, { expr = true, desc = "Delete current line, copy if not empty" })

