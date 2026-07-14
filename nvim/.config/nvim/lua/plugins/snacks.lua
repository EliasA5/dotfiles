local lazygit = function ()
 return {
      ---@class snacks.lazygit.Config: snacks.terminal.Opts
      ---@field args? string[]
      ---@field theme? snacks.lazygit.Theme
        -- automatically configure lazygit to use the current colorscheme
        -- and integrate edit with the current neovim instance
        configure = true,
        theme_path = vim.fs.normalize(vim.fn.stdpath("cache") .. "/lazygit-theme.yml"),
        config = {
          os = { editPreset = "nvim" },
        },
        theme = {
          [241]                      = { fg = "Special" },
          activeBorderColor          = { fg = "MatchParen", bold = true },
          cherryPickedCommitBgColor  = { fg = "Identifier" },
          cherryPickedCommitFgColor  = { fg = "Function" },
          defaultFgColor             = { fg = "Normal" },
          inactiveBorderColor        = { fg = "FloatBorder" },
          optionsTextColor           = { fg = "Function" },
          searchingActiveBorderColor = { fg = "MatchParen", bold = true },
          selectedLineBgColor        = { bg = "Visual" }, -- set to `default` to have no background colour
          unstagedChangesColor       = { fg = "DiagnosticError" },
        },
        win = {
          style = "lazygit",
        },
    }
end

local ff = {mode = 'n', keybind = "<leader>ff", opts = {desc = "Fuzzy find files"}}
local fg = {mode = 'n', keybind = "<leader>fg", opts = {desc = "Live grep inside files"}}
local cp = {mode = 'n', keybind = "<C-p>", opts = {desc = "Search in files indexed by git"}}
local fw = {mode = {'n', 'x'}, keybind = "<leader>fw", opts = {desc = "Search for word under cursor"}}
local gb = {mode = 'n', keybind = "<leader>gb", opts = {desc = "Goto buffers"}}
local fb = {mode = 'n', keybind = "<leader>fb", opts = {desc = "Grep Open Buffers"}}
local fn = {mode = 'n', keybind = "<leader>fn", opts = {desc = "Notification History"}}
local fh = {mode = 'n', keybind = "<leader>fh", opts = {desc = "Find Help"}}
local fc = {mode = 'n', keybind = "<leader>fc", opts = {desc = "Command History"}}
local fs = {mode = 'n', keybind = "<leader>fs", opts = {desc = "Search History"}}

local function make_keybind(opts, fun)
  vim.keymap.set(opts.mode, opts.keybind, fun, opts.opts)
end

local init_picker = function ()
  make_keybind(ff, Snacks.picker.smart)
  make_keybind(fg, Snacks.picker.grep)
  make_keybind(cp, Snacks.picker.git_files)
  make_keybind(fw, Snacks.picker.grep_word)
  make_keybind(gb, Snacks.picker.buffers)
  make_keybind(fb, Snacks.picker.grep_buffers)
  make_keybind(fn, Snacks.picker.notifications)
  make_keybind(fh, Snacks.picker.help)
  make_keybind(fc, Snacks.picker.command_history)
  make_keybind(fs, Snacks.picker.search_history)
end

return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  dependencies = { 'folke/lazydev.nvim' },
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = false },
    dashboard = { enabled = false },
    explorer = { enabled = false },
    indent = { enabled = false },
    input = { enabled = false },
    picker = { enabled = false },
    notifier = { enabled = false },
    quickfile = { enabled = true },
    scope = { enabled = false },
    scroll = { enabled = false },
    statuscolumn = { enabled = false },
    words = { enabled = false },
    lazygit = lazygit(),
  },
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end
        vim.print = _G.dd
        vim.keymap.set('n', '<leader>gs', function()
            Snacks.lazygit({
              win = {
                keys = {
                  ["<c-t>"] = { "hide", mode = { "n", "t" }, desc = "Close Lazygit" },
                },
                -- border = "rounded"
              }
            })
          end,
          {desc = "open lazygit", noremap = true, silent = true}
        )
        vim.keymap.set("n", "<c-t>", function() Snacks.terminal(nil, {win = { border = "rounded", position = "float"}}) end, { desc = "Toggle Terminal", silent = true })
        vim.keymap.set("t", "<c-t>", "<cmd>close<CR>", { desc = "Hide Terminal" })
        vim.keymap.set("n", "<leader>.",  function() Snacks.scratch() end, { desc = "Toggle Scratch Buffer" } )
        init_picker()
      end,
    })
  end,
}
