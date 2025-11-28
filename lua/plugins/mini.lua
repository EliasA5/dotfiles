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
  {
    'nvim-mini/mini.move',
    version = false,
    opts = {
      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        left = 'H',
        right = 'L',
        down = 'J',
        up = 'K',
        line_left = '',
        line_right = '',
        line_down = '',
        line_up = '',
      },
      options = {reindent_linewise = true},
    }
  },
  { 'nvim-mini/mini.jump', version = false, opts = {}},
  {
    'nvim-mini/mini.surround',
    opts = {
      custom_surroundings = {
        ['('] = { input = { '%b()', '^.().*().$' }, output = { left = '(', right = ')' } },
        ['['] = { input = { '%b[]', '^.().*().$' }, output = { left = '[', right = ']' } },
        ['{'] = { input = { '%b{}', '^.().*().$' }, output = { left = '{', right = '}' } },
        ['<'] = { input = { '%b<>', '^.().*().$' }, output = { left = '<', right = '>' } },
        [')'] = { output = { left = '( ', right = ' )' } },
        [']'] = { output = { left = '[ ', right = ' ]' } },
        ['}'] = { output = { left = '{ ', right = ' }' } },
        ['>'] = { output = { left = '< ', right = ' >' } },
      },

      -- Module mappings. Use `''` (empty string) to disable one.
      mappings = {
        add = '<leader>sa', -- Add surrounding in Normal and Visual modes
        delete = '<leader>sd', -- Delete surrounding
        find = '', -- Find surrounding (to the right)
        find_left = '', -- Find surrounding (to the left)
        highlight = '', -- Highlight surrounding
        replace = '<leader>sr', -- Replace surrounding
        update_n_lines = '', -- Update `n_lines`

        suffix_last = 'l', -- Suffix to search with "prev" method
        suffix_next = 'n', -- Suffix to search with "next" method
      },
    }
  }
}
