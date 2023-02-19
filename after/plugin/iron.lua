local iron = require("iron.core")
local view = require("iron.view")

iron.setup {
    config = {
        -- Whether a repl should be discarded or not
        sCRatch_repl = false,
        -- Your repl definitions come here
        repl_definition = {
            sh = {
                -- Can be a table or a function that
                -- returns a table (see below)
                command = {"bash"}
            },
            python = {command = {os.getenv("CONDA_PREFIX") .. "/bin/python"} },
            ocaml = {command = {"utop"}}
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = view.split.vertical.botright("40%", {
            winfixwidth = false,
            winfixheight = false,
            -- any window-local configuration can be used here
            number = true,
            relativenumber = false
        })
    },
    -- Iron doesn't set keymaps by default anymore.
    -- You can set them here or manually add keymaps to the functions in iron.core
    keymaps = {
        send_motion = "<leader>ss",
        visual_send = "<leader>ss",
        send_file = "<leader>sf",
        send_line = "<leader>sl",
        -- send_mark = "<leader>sm",
        -- mark_motion = "<leader>mc",
        -- mark_visual = "<leader>mc",
        -- remove_mark = "<leader>md",
        -- CR = "<leader>r<CR>",
        interrupt = "<leader>ri",
        exit = "<leader>rq",
        clear = "<leader>rl",
    },
    -- If the highlight is on, you can change how it looks
    -- For the available options, check nvim_set_hl
    highlight = {
        italic = true
    },
    ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
}

-- iron also has a list of commands, see :h iron-commands for all available commands
vim.keymap.set('n', '<leader>rs', '<cmd>IronRepl<CR>')
vim.keymap.set('n', '<leader>rr', '<cmd>IronRestart<CR><cmd>IronRepl<CR>', { silent = true} )
-- vim.keymap.set('n', '<leader>rf', '<cmd>IronFocus<CR>')
-- vim.keymap.set('n', '<leader>rh', '<cmd>IronHide<CR>')




