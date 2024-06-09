return
{
  {
    'szw/vim-maximizer',
    keys = {{"<leader>m", vim.cmd.MaximizerToggle, desc = "toggle maximization"}}
  },
  {'EliasA5/pastem', config = function() require('pastem').setup() end},
  'stefandtw/quickfix-reflector.vim',
  -- disable on nvim 0.10.*
  -- enable on nvim 0.10.*
  -- {
  --   "NStefan002/screenkey.nvim",
  --   cmd = "Screenkey",
  --   config = true,
  -- },
}
