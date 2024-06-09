return
{
  {
    'szw/vim-maximizer',
    keys = {{"<leader>m", vim.cmd.MaximizerToggle, desc = "toggle maximization"}}
  },
  {'EliasA5/pastem', config = function() require('pastem').setup() end},
  'stefandtw/quickfix-reflector.vim',
  {
    'nvimdev/template.nvim',
    cmd = {'Template',},
    config = function()
      require('template').setup({
        temp_dir = "~/templates",
        author = "Elias Assaf",
        email = "elyas51000@gmail.com"
      })
    end
  },
  -- disable on nvim 0.10.*
  -- enable on nvim 0.10.*
  -- {
  --   "NStefan002/screenkey.nvim",
  --   cmd = "Screenkey",
  --   config = true,
  -- },
}
