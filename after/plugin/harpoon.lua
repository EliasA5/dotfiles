local harpoon = require('harpoon')
harpoon:setup({})

local entry_display = require("telescope.pickers.entry_display")

local function make_numbers_entry(_opts)
  local displayer = entry_display.create({
    separator = " ",
    hl_chars = { ["["] = "TelescopeBorder", ["]"] = "TelescopeBorder" },
    items = {
      { width = 3 },
      { remaining = true },
    },
  })

  local make_display = function(entry)
    local value = entry.value
    return displayer({
      { "[" .. entry.content .. "]", "TelescopeResultsNumber" },
      value,
    })
  end

  return function(entry)
    return {
      value = entry[2],
      ordinal = entry[1],
      content = entry[1],
      display = make_display,
    }
  end
end

local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for idx, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, {idx, item.value})
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
            entry_maker = make_numbers_entry({}),
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>ha", function() harpoon:list():append() end,
              { desc = "Add file to harpoon list"})
vim.keymap.set("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end,
              { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader>hp", function() harpoon:list():prev() end,
              { desc = "Harpoon prev" })
vim.keymap.set("n", "<leader>hn", function() harpoon:list():next() end,
              { desc = "Harpoon next" })
vim.keymap.set("n", "<leader>hc", function() harpoon:list():clear() end,
              { desc = "Clear Harpoon list" })

