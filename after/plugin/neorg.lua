require("neorg").setup {
        load = {
          ["core.defaults"] = {}, -- Loads default behaviour
          ["core.concealer"] = {}, -- Adds pretty icons to your documents
          ["core.dirman"] = { -- Manages Neorg workspaces
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes"
            },
          },
        },
      }

vim.keymap.set("n", "<leader>ni", ":Neorg index<CR>", {desc = "Open Neorg workspace index", silent = true, })
vim.keymap.set("n", "<leader>nr", ":Neorg return<CR>", {desc = "Return from Neorg", silent = true, })

