return {
  'numToStr/Navigator.nvim',
  lazy = false,
  config = function()
    require('Navigator').setup()
  end,
  keys = {
    {'<C-h>', '<CMD>NavigatorLeft<CR>', {'n', 't'}},
    {'<C-l>', '<CMD>NavigatorRight<CR>', {'n', 't'}},
    {'<C-j>', '<CMD>NavigatorDown<CR>', 'n'},
    {'<C-k>', '<CMD>NavigatorUp<CR>', 'n'},
  }
}

