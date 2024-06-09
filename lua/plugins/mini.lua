return {
  {'echasnovski/mini.pairs',   config = function() require('mini.pairs').setup() end },
  {
    'echasnovski/mini.indentscope',
    opts = {
      mappings = {
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        goto_top = '<leader>gpi',
        goto_bottom = '<leader>gni',
      },
    }
  },
  {'echasnovski/mini.splitjoin', version = '*' , config = function() require('mini.splitjoin').setup() end },
}
