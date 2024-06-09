return
{
  {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'}
  },
  'szw/vim-maximizer',
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
  'akinsho/toggleterm.nvim',
  {
    'lewis6991/gitsigns.nvim',
    -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
  },
  'nvim-tree/nvim-web-devicons',
  'freddiehaddad/feline.nvim',
  'folke/which-key.nvim',
  { 'echasnovski/mini.comment'},
  { 'echasnovski/mini.pairs',   config = function() require('mini.pairs').setup() end },
  { 'echasnovski/mini.surround'},
  { 'echasnovski/mini.indentscope'},
  { 'echasnovski/mini.splitjoin', version = '*' , config = function() require('mini.splitjoin').setup() end },
  'folke/neodev.nvim',
  {'stevearc/oil.nvim', lazy = false, config = function() require('oil').setup() end},
  {
    'ribru17/bamboo.nvim',
    lazy = false,
  },
  {'EliasA5/pastem', config = function() require('pastem').setup() end},
  {'ggandor/leap.nvim', lazy = false,},
  {
    'nvim-neorg/neorg',
    build = ':Neorg sync-parsers',
    dependencies = { 'nvim-lua/plenary.nvim' },
    version = "7.*"
  },
  {
    'numToStr/Navigator.nvim',
    lazy = false,
    config = function()
      require('Navigator').setup()
    end
  },
  'otavioschwanck/arrow.nvim',
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
  'ojroques/nvim-osc52',
  -- enable on nvim 0.10.*
  -- {
  --   "NStefan002/screenkey.nvim",
  --   cmd = "Screenkey",
  --   config = true,
  -- },
}
