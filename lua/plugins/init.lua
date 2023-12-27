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
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {                                      -- Optional
            'williamboman/mason.nvim',
            build = function()
                pcall(vim.cmd, 'MasonUpdate')
            end,
        },
        {'williamboman/mason-lspconfig.nvim'}, -- Optional

        -- Autocompletion
        {'hrsh7th/nvim-cmp'},     -- Required
        {'hrsh7th/cmp-nvim-lsp'}, -- Required
        {'L3MON4D3/LuaSnip'},     -- Required
    }
	},
    'voldikss/vim-floaterm',
    {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    },
    'nvim-tree/nvim-web-devicons',
    'freddiehaddad/feline.nvim',
    'nvim-tree/nvim-tree.lua',
    'folke/which-key.nvim',
    { 'echasnovski/mini.comment'},
    { 'echasnovski/mini.pairs',   config = function() require('mini.pairs').setup() end },
    { 'echasnovski/mini.surround'},
    { 'echasnovski/mini.indentscope', config = function() require('mini.indentscope').setup() end },
    'folke/neodev.nvim',
    -- {'christoomey/vim-tmux-navigator', lazy = false},
    {'stevearc/oil.nvim', lazy = false, config = function() require('oil').setup() end},
	{'ribru17/bamboo.nvim',
		lazy = false,
	},
	{'EliasA5/pastem', config = function() require('pastem').setup() end},
	{'EliasA5/erlang-skeletons', branch = 'spaces', config = function() require('erlang-skeletons').setup() end},
	{'ggandor/leap.nvim', lazy = false, config = function() require('leap').add_default_mappings() end, },
	"EliasA5/elixir-docs.nvim",
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    'numToStr/Navigator.nvim',
    lazy = false,
    config = function()
        require('Navigator').setup()
    end
  },
  'ojroques/nvim-osc52',
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = { "nvim-lua/plenary.nvim",
                     "nvim-telescope/telescope.nvim",
                   },
  },
}
