return
{
    {
        'nvim-telescope/telescope.nvim', tag = '0.1.1',
        -- or                            , branch = '0.1.x',
        dependencies = { 'nvim-lua/plenary.nvim' }
    },
    'Mofiqul/dracula.nvim',
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'}
    },
    'nvim-treesitter/playground',
    'christoomey/vim-tmux-navigator',
    'szw/vim-maximizer',
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v1.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},             -- Required
            {'williamboman/mason.nvim'},           -- Optional
            {'williamboman/mason-lspconfig.nvim'}, -- Optional

            -- Autocompletion
            {'hrsh7th/nvim-cmp'},         -- Required
            {'hrsh7th/cmp-nvim-lsp'},     -- Required
            {'hrsh7th/cmp-buffer'},       -- Optional
            {'hrsh7th/cmp-path'},         -- Optional
            {'saadparwaiz1/cmp_luasnip'}, -- Optional
            {'hrsh7th/cmp-nvim-lua'},     -- Optional

            -- Snippets
            {'L3MON4D3/LuaSnip'},             -- Required
            {'rafamadriz/friendly-snippets'}, -- Optional
        }
    },    
    'voldikss/vim-floaterm',
    {'hkupty/iron.nvim'},
    {
        'lewis6991/gitsigns.nvim',
        -- tag = 'release' -- To use the latest release (do not use this if you run Neovim nightly or dev builds!)
    },
    'nvim-tree/nvim-web-devicons',
    'freddiehaddad/feline.nvim',
    'nvim-tree/nvim-tree.lua',
    'folke/which-key.nvim', 
    { 'echasnovski/mini.comment', config = function() require('mini.comment').setup() end },
    { 'echasnovski/mini.pairs',   config = function() require('mini.pairs').setup() end },
    { 'echasnovski/mini.surround'},
    'folke/neodev.nvim',

}
