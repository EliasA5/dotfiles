return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    branch = "main",
    config = function ()
      local ts = require('nvim-treesitter')

      -- Track buffers waiting for parser installation: { lang = { [buf] = true, ... } }
      local waiting_buffers = {}
      -- Track languages currently being installed to avoid duplicate install tasks
      local installing_langs = {}

      local group = vim.api.nvim_create_augroup('TreesitterSetup', { clear = true })

      -- Enable treesitter for a buffer
      local function enable_treesitter(buf, lang)
        if not vim.api.nvim_buf_is_valid(buf) then
          return false
        end

        local ok = pcall(vim.treesitter.start, buf, lang)
        if ok then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
          -- vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
          -- vim.wo[0][0].foldmethod = "expr"
        end
        return ok
      end

      local function is_installed(lang)
        return require('nvim-treesitter').get_installed()[lang] ~= nil
      end

      -- Install core parsers after lazy.nvim finishes loading all plugins
      vim.api.nvim_create_autocmd('User', {
        group = group,
        pattern = 'LazyDone',
        once = true,
        desc = 'Install core treesitter parsers',
        callback = function()
          ts.install({
            'bash',
            'lua',
            'luadoc',
            'markdown',
            'markdown_inline',
            'regex',
            'vim',
            'vimdoc',
          },
          {
            max_jobs = 8,
          }
          )
        end,
      })

      local ignore_filetypes = {
        checkhealth = true,
        lazy = true,
        mason = true,
        qf = true,
        snacks_dashboard = true,
        snacks_notif = true,
        snacks_win = true,
        toggleterm = true,
      }

      -- Auto-install parsers and enable highlighting on FileType
      vim.api.nvim_create_autocmd('FileType', {
        group = group,
        desc = 'Enable treesitter highlighting and indentation',
        callback = function(event)
          if ignore_filetypes[event.match] then
            return
          end

          local lang = vim.treesitter.language.get_lang(event.match) or event.match
          local buf = event.buf

          if lang ~= nil and not is_installed(lang) then
            -- Parser not available, queue buffer (set handles duplicates)
            waiting_buffers[lang] = waiting_buffers[lang] or {}
            waiting_buffers[lang][buf] = true

            -- Only start install if not already in progress
            if not installing_langs[lang] then
              installing_langs[lang] = true
              local task = ts.install({ lang })

              -- Register callback for when installation completes
              if task and task.await then
                task:await(function()
                  vim.schedule(function()
                    installing_langs[lang] = nil

                    -- Enable treesitter on all waiting buffers for this language
                    local buffers = waiting_buffers[lang]
                    if buffers then
                      for b in pairs(buffers) do
                        enable_treesitter(b, lang)
                      end
                      waiting_buffers[lang] = nil
                    end
                  end)
                end)
              else
                -- Fallback: clear state if task doesn't support await
                installing_langs[lang] = nil
                waiting_buffers[lang] = nil
              end
            end
          end
        end,
      })

      -- Clean up waiting buffers when buffer is deleted
      vim.api.nvim_create_autocmd('BufDelete', {
        group = group,
        desc = 'Clean up treesitter waiting buffers',
        callback = function(event)
          for lang, buffers in pairs(waiting_buffers) do
            buffers[event.buf] = nil
            if next(buffers) == nil then
              waiting_buffers[lang] = nil
            end
          end
        end,
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
