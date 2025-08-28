return {
  {'nvim-mini/mini.pairs', version = false, opts = {}},
  {
    'nvim-mini/mini.indentscope',
    opts = {
      mappings = {
        object_scope = 'ii',
        object_scope_with_border = 'ai',
        goto_top = '<leader>gpi',
        goto_bottom = '<leader>gni',
      },
    }
  },
  {'nvim-mini/mini.splitjoin', version = false, opts = {}},
  {'nvim-mini/mini.cursorword', version = false, opts = {}},
  {
    'nvim-mini/mini.notify',
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
  {
    'nvim-mini/mini.comment',
    opts = {
      options = {
        ignore_blank_line = true,
        start_of_line = false,
        pad_comment_parts = true,
      },
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        comment = 'gc',
        comment_line = 'gcc',
        textobject = 'gc',
      },
    }
  },
}
