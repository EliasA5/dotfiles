
local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

end

require("nvim-tree").setup {
    on_attach = on_attach,
    hijack_netrw = false,
    disable_netrw = false,
    reload_on_bufenter = true,
    renderer = { highlight_opened_files = "all" },
    sync_root_with_cwd = true,
    respect_buf_cwd = true,
    update_focused_file = {
        enable = true,
        update_root = true,
        ignore_list = { "toggleterm", "term" },
    },
    filters = { dotfiles = false },
    git = { enable = true, ignore = false, timeout = 500, },
    view = {
        cursorline = true,
        preserve_window_proportions = true,
        -- mappings = {
        --     custom_only = true,
        --     list = {
        --     },
        -- },
    },
    actions = {
        open_file = {
            quit_on_open = false,
        },
        change_dir = {
            enable = true,
            global = false,
            restrict_above_cwd = false,
        },
    },
}

local tree = require("nvim-tree.api").tree

vim.keymap.set("n", "<leader>ft", function() tree.toggle({ focus = false }) end, { desc = "Filetree Toggle", silent = true })

-- vim.api.nvim_create_autocmd({ "VimEnter" }, {
--     callback = function() tree.toggle({focus = false}) end
-- })

vim.api.nvim_create_autocmd({"QuitPre"}, {
    callback = function() vim.cmd("NvimTreeClose") end,
})

