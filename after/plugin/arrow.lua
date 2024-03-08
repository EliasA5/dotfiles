
require('arrow').setup({
  show_icons = true,
  leader_key = '<leader>hl',
  mappings = {
    edit = "e",
    delete_mode = "d",
    clear_all_items = "C",
    toggle = "s",
    open_vertical = "v",
    open_horizontal = "h",
    quit = "q",
    remove = "x",
  },
  separate_by_branch = true,
})
vim.keymap.set("n", "<leader>ha", require("arrow.persist").toggle)

