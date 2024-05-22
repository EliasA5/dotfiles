require("toggleterm").setup()

local Terminal  = require('toggleterm.terminal').Terminal
-- can also give cmd to run on another server, i.e
-- cmd = 'ssh -t some.server "cd $(pwd) ; source ~/.bash_profile ; lazygit"',
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  float_opts = {
    border = "double",
  },
  on_open = function(term)
    vim.cmd("startinsert!")
    vim.api.nvim_buf_set_keymap(term.bufnr, "n", "q", "<cmd>close<CR>", {noremap = true, silent = true})
  end,
  on_close = function(term)
    vim.cmd("startinsert!")
  end,
})

function _lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap("n", "<leader>gs", "<cmd>lua _lazygit_toggle()<CR>", {noremap = true, silent = true})


-- vim.keymap.set('n', '<M-t>', ':FloatermKill term<CR>')
-- vim.keymap.set('n', '<C-t>', ':ToggleTermToggleAll<CR>')
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:ToggleTermToggleAll<CR>', { silent = true } )
