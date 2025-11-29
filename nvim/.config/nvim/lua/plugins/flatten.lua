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
      },
    }
  end,
}
