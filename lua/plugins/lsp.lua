return {
  {
    'williamboman/mason.nvim',
    build = function()
      pcall(vim.cmd, 'MasonUpdate')
    end,
    lazy = true,
    ft = {"c", "cpp", "rust", "python", "go", "bash", "sh", "lua"},
    cmd = {"LspInfo", "LspInstall", "LspUninstall", "Mason"},
    config = function()
      require('mason').setup({})
      require('mason-lspconfig').setup({})
      require('lspconfig')

      vim.api.nvim_create_autocmd('LspAttach', {
        group = vim.api.nvim_create_augroup('my.lsp', {}),
        callback = function(args)
          local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

          if client:supports_method('textDocument/completion') then
            vim.lsp.completion.enable(true, client.id, args.buf, {autotrigger = true})
          end
          local map = function(mode, keys, func, opts)
            opts = opts or {}

            opts["buffer"] = args.buf
            vim.keymap.set(mode, keys, func, opts)
          end

          map('n', '<leader>gf', vim.lsp.buf.code_action, {desc = "LSP code action"})
          map('n', '<leader>tt', '<cmd>Telescope diagnostics<CR>', { desc = "LSP Diagnostics", noremap = true, silent = true })
          map('n', '<leader>tl', vim.diagnostic.open_float, { desc = "Open diagnostic float", noremap = true, silent = true })
          map('n', '<leader>rr', vim.lsp.buf.rename, {desc = "Rename symbol under cursor"})
          map('n', 'K', vim.lsp.buf.hover, {desc = "Hover Documentation"})
          map('n', '<M-k>', vim.lsp.buf.signature_help, {desc = "Signature Documentation"})

          local builtin = require('telescope.builtin')
          map('n', 'gd', builtin.lsp_definitions, {desc = "LSP Defnition"})
          map('n', 'gD', builtin.lsp_type_definitions, {desc = "LSP Type Definition"})
          map('n', 'gr', builtin.lsp_references, {desc = "LSP References"})
          map('n', '<leader>fc', builtin.lsp_incoming_calls, {desc = "Fuzzy find function calls"})
          -- vim.keymap.set('n', 'gi', builtin.lsp_implementations, {desc = "LSP Implementation"})

          local virtual_text = false
          vim.diagnostic.config({ virtual_text = virtual_text, })
          map('n', '<leader>tv', function()
            virtual_text = not virtual_text
            vim.diagnostic.config({ virtual_text = virtual_text, })
          end, { desc = "Toggle diagnostic virtual text", })
        end,
      })
    end
  },
  {'williamboman/mason-lspconfig.nvim', lazy = true},
  {'neovim/nvim-lspconfig', lazy = true},
  {
    'folke/lazydev.nvim',
    ft = 'lua',
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
    },
  },
  {
    'saghen/blink.cmp',
    dependencies = { 'rafamadriz/friendly-snippets' },

    version = '1.*',
    opts = {
      keymap = { preset = 'enter' },

      appearance = {
        nerd_font_variant = 'mono'
      },

      completion = {
        documentation = { auto_show = true },
        ghost_text = { enabled = true },
        -- list = {
        --   selection = { preselect = false, auto_insert = true }
        -- }
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },

      fuzzy = { implementation = "prefer_rust_with_warning" },

      signature = { enabled = true },
    },
    opts_extend = { "sources.default" }
  }
}
