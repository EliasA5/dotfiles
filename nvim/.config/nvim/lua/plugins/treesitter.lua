return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = "main",
  },
  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    config = function()
      require("treesitter-modules").setup({
        ensure_installed = {
          "bash",
          "python",
          "lua",
          "c",
          "cpp",
          "go",
          "rust",
          "luadoc",
          "markdown",
          "markdown_inline",
          "query",
          "regex",
          "vim",
          "vimdoc"
        },
        ignore_install = {},
        sync_install = false,
        -- Automatically install missing parsers when entering buffer
        -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
        auto_install = true,
        highlight = { enable = true },
        indent = { enable = true },
        fold = { enable = false },
      })
    end,
  },
  {"nvim-treesitter/nvim-treesitter-context", opts = {}},
  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    init = function()
      -- Disable entire built-in ftplugin mappings to avoid conflicts.
      -- See https://github.com/neovim/neovim/tree/master/runtime/ftplugin for built-in ftplugins.
      -- vim.g.no_plugin_maps = true

    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter-textobjects").setup({
        move = {
          set_jumps = true,
        },
        select = {
          lookahead = true,
          selection_modes = {
            ['@parameter.outer'] = 'v', -- charwise
            ['@function.outer'] = 'V', -- linewise
            ['@class.outer'] = '<c-v>', -- blockwise
          },
        },
      })
      -- move keybinds
      local goto_next_start = require("nvim-treesitter-textobjects.move").goto_next_start
      local goto_prev_start = require("nvim-treesitter-textobjects.move").goto_previous_start

      vim.keymap.set({ "n", "x", "o" }, "[[", function()
        goto_prev_start("@parameter.inner", "textobjects")
      end, { desc = "goto prev parameter" })

      vim.keymap.set({ "n", "x", "o" }, "[f", function()
        goto_prev_start("@function.inner", "textobjects")
      end, { desc = "goto prev function body" })

      vim.keymap.set({ "n", "x", "o" }, "[c", function()
        goto_prev_start("@class.outer", "textobjects")
      end, { desc = "goto prev class" })

      vim.keymap.set({ "n", "x", "o" }, "]]", function()
        goto_next_start("@parameter.inner", "textobjects")
      end, { desc = "goto next parameter" })

      vim.keymap.set({ "n", "x", "o" }, "]f", function()
        goto_next_start("@function.inner", "textobjects")
      end, { desc = "goto next function body" })

      vim.keymap.set({ "n", "x", "o" }, "]c", function()
        goto_next_start("@class.outer", "textobjects")
      end, { desc = "goto next class" })

      -- select keybinds
      local select = require("nvim-treesitter-textobjects.select").select_textobject
      vim.keymap.set({ "x", "o" }, "iq", function()
        select("@parameter.inner", "textobjects")
      end, { desc = "Select inner part of function parameter" })

      vim.keymap.set({ "x", "o" }, "aq", function()
        select("@parameter.outer", "textobjects")
      end, { desc = "Select outer part of function parameter" })

      vim.keymap.set({ "x", "o" }, "if", function()
        select("@function.inner", "textobjects")
      end, { desc = "Select inner part of the function" })

      vim.keymap.set({ "x", "o" }, "af", function()
        select("@function.outer", "textobjects")
      end, { desc = "Select outer part of the function" })

      vim.keymap.set({ "x", "o" }, "ic", function()
        select("@class.inner", "textobjects")
      end, { desc = "Select inner part of the class" })

      vim.keymap.set({ "x", "o" }, "ac", function()
        select("@class.outer", "textobjects")
      end, { desc = "Select outer part of the class" })

      vim.keymap.set({ "x", "o" }, "as", function()
        select("@local.scope", "locals")
      end, { desc = "Select outer part of the scope" })

      -- swap keybinds
      local swap_next = require("nvim-treesitter-textobjects.swap").swap_next
      local swap_prev = require("nvim-treesitter-textobjects.swap").swap_previous

      vim.keymap.set("n", "<leader>q", function()
        swap_next("@parameter.inner")
      end, { desc = "Swap with next parameter" })
      vim.keymap.set("n", "<leader>Q", function()
        swap_prev("@parameter.inner")
      end, { desc = "Swap with prev parameter" })

      local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")

      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)

      vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
      vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })

    end,
  }
}
