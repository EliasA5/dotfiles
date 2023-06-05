-- local dracula = require("dracula")
-- dracula.setup({
--   -- customize dracula color palette
--   colors = {
--     bg = "#282A36",
--     fg = "#F8F8F2",
--     selection = "#44475A",
--     comment = "#6272A4",
--     red = "#FF5555",
--     orange = "#FFB86C",
--     yellow = "#F1FA8C",
--     green = "#50fa7b",
--     purple = "#BD93F9",
--     cyan = "#8BE9FD",
--     pink = "#FF79C6",
--     bright_red = "#FF6E6E",
--     bright_green = "#69FF94",
--     bright_yellow = "#FFFFA5",
--     bright_blue = "#D6ACFF",
--     bright_magenta = "#FF92DF",
--     bright_cyan = "#A4FFFF",
--     bright_white = "#FFFFFF",
--     menu = "#21222C",
--     visual = "#3E4452",
--     gutter_fg = "#4B5263",
--     nontext = "#3B4048",
--   },
--   -- show the '~' characters after the end of buffers
--   show_end_of_buffer = true, -- default false
--   -- use transparent background
--   transparent_bg = true, -- default false
--   -- set custom lualine background color
--   lualine_bg_color = "#44475a", -- default nil
--   -- overrides the default highlights see `:h synIDattr`
--   overrides = {
--     -- Examples
--     -- NonText = { fg = dracula.colors().white }, -- set NonText fg to white
--     -- NvimTreeIndentMarker = { link = "NonText" }, -- link to NonText highlight
--     -- Nothing = {} -- clear highlight of Nothing
--   },
-- })

-- vim.cmd.colorscheme('dracula')

require('bamboo').setup  {
    -- Main options --
    transparent = true,  -- Show/hide background
    term_colors = true, -- Change terminal color as per the selected theme style
    ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
    cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu

    -- Change code style ---
    -- Options are italic, bold, underline, none
    -- You can configure multiple style with comma separated, For e.g., keywords = 'italic,bold'
    code_style = {
        comments = 'italic',
        keywords = 'none',
        functions = 'none',
        strings = 'none',
        variables = 'none'
    },

    -- Lualine options --
    lualine = {
        transparent = false, -- lualine center bar transparency
    },

    -- Custom Highlights --
    colors = {}, -- Override default colors
    highlights = {}, -- Override highlight groups

    -- Plugins Config --
    diagnostics = {
        darker = false, -- darker colors for diagnostic
        undercurl = true,   -- use undercurl instead of underline for diagnostics
        background = true,    -- use background color for virtual text
    },
}
require('bamboo').load()

-- vim.api.nvim_set_hl(0, "Normal", {bg = "none" })
-- vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none" })

