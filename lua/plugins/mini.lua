return {
  {'echasnovski/mini.pairs', version = false, opts = {}},
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
  {'echasnovski/mini.splitjoin', version = false, opts = {}},
  {'echasnovski/mini.cursorword', version = false, opts = {}},
  {
    'echasnovski/mini.notify',
    version = false,
    config = function ()
      local notify = require('mini.notify')
      notify.setup()
      vim.notify = notify.make_notify({
        ERROR = { duration = 3000 },
        WARN = { duration = 3000 },
        INFO = { duration = 2000 },
      })
    end,
  },
}
