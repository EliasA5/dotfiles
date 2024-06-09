return
{
  {
    'szw/vim-maximizer',
    keys = {{"<leader>m", vim.cmd.MaximizerToggle, desc = "toggle maximization"}}
  },
  {
    'williamboman/mason.nvim',
    build = function()
      pcall(vim.cmd, 'MasonUpdate')
    end,
  },
  'williamboman/mason-lspconfig.nvim',
  'neovim/nvim-lspconfig',
  {'hrsh7th/nvim-cmp'},
  {'hrsh7th/cmp-nvim-lsp'},
  {'L3MON4D3/LuaSnip'},
  'folke/neodev.nvim',
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
