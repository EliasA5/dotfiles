return
{
	{ 'echasnovski/mini.comment', config = function() require('mini.comment').setup() end },
	{ 'echasnovski/mini.surround',  config = function() require('mini.surround').setup() end },
	{ 'ggandor/leap.nvim', config = function() require('leap').add_default_mappings() end },
}
