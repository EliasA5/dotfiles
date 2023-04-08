
require('mini.surround').setup({
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
})

