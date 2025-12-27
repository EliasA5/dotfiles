return {
  {
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
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

          if not enable_treesitter(buf, lang) then
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
      vim.g.no_plugin_maps = true

    end,
    dependencies = "nvim-treesitter/nvim-treesitter",
    config = function()
      require("nvim-treesitter-textobjects").setup({
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
      })
      local ts_repeat_move = require("nvim-treesitter-textobjects.repeatable_move")
      vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
      vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)

    end,
  }
}
