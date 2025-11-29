return
{
	{ 'echasnovski/mini.comment', config = function() require('mini.comment').setup() end },
	{ 'echasnovski/mini.surround'},
	{ 'ggandor/leap.nvim', lazy = false, config = function() require('leap').add_default_mappings() end },
	{ 'EliasA5/pastem', config = function() require('pastem').setup() end },
  'michaeljsmith/vim-indent-object'
}
