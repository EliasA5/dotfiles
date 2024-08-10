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
      local on_attach = function(_, bufnr)
        local map = function(mode, keys, func, opts)
          opts = opts or {}

          opts["buffer"] = bufnr
          vim.keymap.set(mode, keys, func, opts)
        end

        -- map('n', '<leader>gf', vim.lsp.buf.code_action, {desc = "LSP code action"})
        map('n', '<leader>tt', '<cmd>Telescope diagnostics<CR>', { desc = "LSP Diagnostics", noremap = true, silent = true })
        map('n', '<leader>tl', vim.diagnostic.open_float, { desc = "Open diagnostic float", noremap = true, silent = true })
        map('n', '<leader>rr',
        function()
          require("elias.custom.rename").rename({})
        end, {desc = "Rename symbol under cursor"})
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

      end


      require('mason').setup({})
      require('mason-lspconfig').setup({})
      local lspconfig = require('lspconfig')

      local servers = {
        clangd = {},
        pylsp = {
          settings = {
            pylsp = {
              configurationSources = {"flake8"},
              plugins = {
                flake8 = { enabled = true },
              }
            }
          }
        },
        -- erlangls = {
          --   root_dir = lspconfig.util.root_pattern('erlang_ls.config', '.git')
          -- },
          lua_ls = {
            Lua = {
              workspace = { checkThirdParty = false },
              telemetry = { enable = false },
              diagnostics = { disable = { 'missing-fields' } },
            },
          },
        }

        require('neodev').setup()

        local capabilities = vim.lsp.protocol.make_client_capabilities()
        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

        local mason_lspconfig = require('mason-lspconfig')
        mason_lspconfig.setup({
          ensure_installed = vim.tbl_keys(servers),
        })
        mason_lspconfig.setup_handlers({
          function(server_name)
            require('lspconfig')[server_name].setup({
              capabilities = capabilities,
              on_attach = on_attach,
              settings = servers[server_name],
              filetypes = (servers[server_name] or {}).filetypes,
            })
          end,
        })

        local cmp = require('cmp')
        local luasnip = require('luasnip')
        require('luasnip.loaders.from_vscode').lazy_load()
        luasnip.config.setup({})

        cmp.setup({
          snippet = {
            expand = function(args)
              luasnip.lsp_expand(args.body)
            end,
          },
          completion = {
            completeopt = 'menu,menuone,noinsert',
          },
          mapping = {
            ['<CR>'] = cmp.mapping.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = true,
            }),
            ["<C-s>"] = cmp.mapping(cmp.mapping.complete({
              reason = cmp.ContextReason.Auto,
            }), {"i", "c"}),
            ['<Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_next_item()
              elseif luasnip.expand_or_locally_jumpable() then
                luasnip.expand_or_jump()
              else
                fallback()
              end
            end, { 'i', 's' }),
            ['<S-Tab>'] = cmp.mapping(function(fallback)
              if cmp.visible() then
                cmp.select_prev_item()
              elseif luasnip.locally_jumpable(-1) then
                luasnip.jump(-1)
              else
                fallback()
              end
            end, { 'i', 's' }),
          },
          sources = {
            { name = 'nvim_lsp' },
            { name = 'luasnip' },
            { name = 'path' },
          },
        })
      end
    },
    {'williamboman/mason-lspconfig.nvim', lazy = true},
    {'neovim/nvim-lspconfig', lazy = true},
    {'hrsh7th/nvim-cmp', lazy = true},
    {'hrsh7th/cmp-nvim-lsp', lazy = true},
    {'L3MON4D3/LuaSnip', lazy = true},
    {'folke/neodev.nvim', lazy = true},
  }

