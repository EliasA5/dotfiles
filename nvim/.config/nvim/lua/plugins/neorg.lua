local _neorg = {
  "nvim-neorg/neorg",
  lazy = false,
  -- version = "*",
  version = false,
  ft = "norg",
  config = function()
    require("neorg").setup({
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
    } )
  end,
  keys = {
    {"<leader>ni", ":Neorg index<CR>", "n", desc = "Open Neorg workspace index", silent = true, },
    {"<leader>nr", ":Neorg return<CR>", "n", desc = "Return from Neorg", silent = true, },
  }
}

return {}
