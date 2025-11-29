return {
  'willothy/flatten.nvim',
  config = true,
  lazy = false,
  priority = 1001,
  opts = function()
    ---@type Terminal?
    local saved_terminal

    return {
      window = {
        open = "alternate",
      },
      hooks = {
        should_block = function(argv)
          -- block if we are diffing between files, like in git commit etc
          return vim.tbl_contains(argv, "-d")
        end,
        pre_open = function()
          local term = require("toggleterm.terminal")
          local termid = term.get_focused_id()
          saved_terminal = term.get(termid)
        end,
        post_open = function(bufnr, winnr, ft, is_blocking)
          if is_blocking and saved_terminal then
            saved_terminal:close()
          elseif winnr ~= nil then
            vim.api.nvim_set_current_win(winnr)
          end
        end,
        block_end = function()
          -- After blocking ends (for a git commit, etc), reopen the terminal
          vim.schedule(function()
            if saved_terminal then
              saved_terminal:open()
              saved_terminal = nil
            end
          end)
        end,
      },
    }
  end,
}
