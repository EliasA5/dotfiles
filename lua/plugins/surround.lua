return {
  'mini.surround',
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
