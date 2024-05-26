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

local term = Terminal:new({
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

function _term_toggle()
  term:toggle()
end



vim.keymap.set('n', '<leader>gs', '<cmd>lua _lazygit_toggle()<CR>', {noremap = true, silent = true})
vim.keymap.set('n', '<C-t>', '<cmd>lua _term_toggle()<CR>')
vim.keymap.set('t', '<C-t>', '<C-\\><C-n>:ToggleTermToggleAll<CR>', { silent = true } )
