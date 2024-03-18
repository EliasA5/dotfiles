
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

vim.keymap.set("n", "<leader>ha", function()
  require("arrow.persist").toggle()
  local ans = "Removed file from arrow list"
  local is_arrow = require('arrow.statusline').is_on_arrow_file()
  if is_arrow then
    ans = "Added file to arrow list"
  end
  print(ans)
end,{ desc = "Add or remove file from arrow list"} )

