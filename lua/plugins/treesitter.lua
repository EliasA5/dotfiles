return {
  'nvim-treesitter/nvim-treesitter',
  build = ':TSUpdate',
  dependencies = {'nvim-treesitter/nvim-treesitter-textobjects'},
  config = function ()
    local configs = require("nvim-treesitter.configs")
    configs.setup({
      -- A list of parser names, or "all" (the four listed parsers should always be installed)
      ensure_installed = { "c", "erlang", "python", "scheme", "ocaml", "lua", "vim", "vimdoc", "query"},

      -- Install parsers synchronously (only applied to `ensure_installed`)
      sync_install = false,

      -- Automatically install missing parsers when entering buffer
      -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
      auto_install = true,

      highlight = {
        enable = true,

        -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
        -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
        -- Using this option may slow down your editor, and you may see some duplicate highlights.
        -- Instead of true it can also be a list of languages
        additional_vim_regex_highlighting = false,
      },

      textobjects = {
        move = {
          enable = true,
          set_jumps = true,
          goto_previous_start = {
            ["[["] = "@parameter.inner",
            ["<leader>gpf"] = "@function.outer",
            ["<leader>gpc"] = "@class.outer",
          },
          goto_next_start = {
            ["]]"] = "@parameter.inner",
            ["<leader>gnf"] = "@function.outer",
            ["<leader>gnc"] = "@class.outer",
          },
        },
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["iq"] = {query = "@parameter.inner", desc = "Select inner part of function parameter" },
            ["aq"] = {query = "@parameter.outer", desc = "Select outer part of function parameter" },
            ["if"] = {query = "@function.inner", desc = "Select inner part of the function" },
            ["af"] = {query = "@function.outer", desc = "Select inner part of the function" },
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>q"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>Q"] = "@parameter.inner",
          },
        },
      },

    })
    local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
    vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
  end,

}
