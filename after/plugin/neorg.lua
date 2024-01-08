require("neorg").setup {
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes"
            },
          },
          ["core.export"] = {},
          ["core.export.markdown"] = {},
        },
      }

vim.keymap.set("n", "<leader>ni", ":Neorg index<CR>", {desc = "Open Neorg workspace index", silent = true, })
vim.keymap.set("n", "<leader>nr", ":Neorg return<CR>", {desc = "Return from Neorg", silent = true, })

