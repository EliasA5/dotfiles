return {
  'nvim-neorg/neorg',
  build = ':Neorg sync-parsers',
  dependencies = { 'nvim-lua/plenary.nvim' },
  version = "7.*",
  ft = "norg",
  opts = {
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
  },
  keys = {
    {"<leader>ni", ":Neorg index<CR>", "n", desc = "Open Neorg workspace index", silent = true, },
    {"<leader>nr", ":Neorg return<CR>", "n", desc = "Return from Neorg", silent = true, },
  }
}
