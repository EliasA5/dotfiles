
require('osc52').setup {
  max_length = 0,
  silent = true,
  trim = false,
  tmux_passthrough = true,
}

local function copy(lines, _)
  require('osc52').copy(table.concat(lines, '\n'))
end

local function paste()
  return {vim.fn.split(vim.fn.getreg(''), '\n'), vim.fn.getregtype('')}
end

vim.g.clipboard = {
  name = 'osc52',
  copy = {['+'] = copy, ['*'] = copy},
  paste = {['+'] = paste, ['*'] = paste},
}

-- enable on nvim 0.10.*
-- vim.g.clipboard = {
--   name = 'OSC 52',
--   copy = {
--     ['+'] = require('vim.clipboard.osc52').copy,
--     ['*'] = require('vim.clipboard.osc52').copy,
--   },
--   paste = {
--     ['+'] = require('vim.clipboard.osc52').paste,
--     ['*'] = require('vim.clipboard.osc52').paste,
--   },
-- }
