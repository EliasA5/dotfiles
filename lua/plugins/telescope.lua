local ff = {mode = 'n', keybind = "<leader>ff", opts = {desc = "Fuzzy find files"}}
local fg = {mode = 'n', keybind = "<leader>fg", opts = {desc = "Live grep inside files"}}
local cp = {mode = 'n', keybind = "<C-p>", opts = {desc = "Search in files indexed by git"}}
local fw = {mode = 'n', keybind = "<leader>fw", opts = {desc = "Search for word under cursor"}}
local fwv = {mode = 'v', keybind = "<leader>fw", opts = {desc = "Search for visual selection"}}
local gb = {mode = 'n', keybind = "gb", opts = {desc = "Goto buffers"}}

local function make_keybind(opts, fun)
  vim.keymap.set(opts.mode, opts.keybind, fun, opts.opts)
end
local function make_lazybind(opts)
  return {opts.keybind, nil, opts.mode, desc = opts.opts.desc}
end
local function make_bind(opts, fun)
  if fun == nil then
    return make_lazybind(opts)
  end
  make_keybind(opts, fun)
end

return {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  dependencies = {'nvim-lua/plenary.nvim'},
  lazy = true,
  keys = {
    make_bind(ff),
    make_bind(fg),
    make_bind(cp),
    make_bind(fw),
    make_bind(gb),
    make_bind(fwv),
  },
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
              ["<C-h>"] = actions.select_horizontal,
              ["<C-x>"] = false,
              ["<C-p>"] = false,
              ["<C-n>"] = false,
            },
          },
        },
      },
    })

    local builtin = require('telescope.builtin')
    make_bind(ff, builtin.find_files)
    make_bind(fg, builtin.live_grep)
    make_bind(cp, builtin.git_files)
    make_bind(fw, builtin.grep_string)
    make_bind(gb, builtin.buffers)
    make_bind(fwv, function()
      -- TODO wait for a better way to get visual selection value
      vim.cmd('noau normal! "vy"')
      local text = vim.fn.getreg('v')
      vim.fn.setreg('v', {})
      text = string.gsub(text, "\n", "")
      builtin.grep_string({ search = text,})
    end)

  end,
}

