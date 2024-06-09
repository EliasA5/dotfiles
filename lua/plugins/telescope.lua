return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {'nvim-lua/plenary.nvim'},
  config = function()
    local actions = require("telescope.actions")
    require("telescope").setup({
      pickers = {
        find_files = {
          mappings = {
            i = {
              ["<C-j>"] = {
                actions.move_selection_next, type = "action",
                opts = { nowait = true, silent = true }
              },
              ["<C-k>"] = {
                actions.move_selection_previous, type = "action",
                opts = { nowait = true, silent = true }
              },
              ["<C-p>"] = false,
              ["<C-n>"] = false,
            },
          },
        },
      },
    })

    local builtin = require('telescope.builtin')
    vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = "Fuzzy find files"})
    vim.keymap.set('n', '<leader>fg', builtin.live_grep, {desc = "Live grep inside files"})
    vim.keymap.set('n', '<C-p>', builtin.git_files, {desc = "Search in files indexed by git"})
    vim.keymap.set('n', '<leader>fw', builtin.grep_string, {desc = "Search for word under cursor"})
    vim.keymap.set('v', '<leader>fw', function()
      -- TODO wait for a better way to get visual selection value
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg('v')
      vim.fn.setreg('v', {})

      text = string.gsub(text, "\n", "")
      builtin.grep_string({ search = text,})
    end, {desc = "Search for visual selection"})
    vim.keymap.set('n', 'gb', builtin.buffers, {desc = "Goto buffers"})
  end

}

