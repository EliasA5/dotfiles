return {
  'willothy/flatten.nvim',
  config = true,
  lazy = false,
  priority = 1001,
  opts = function()
    local saved_terminal_win

    return {
      window = {
        open = "alternate",
      },
      hooks = {
        should_block = function(argv)
          -- block if we are diffing between files, like in git commit etc
          return require("flatten").hooks.should_block(argv)
        end,
        pre_open = function()
          if vim.bo.filetype == "snacks_terminal" then
            saved_terminal_win = vim.api.nvim_get_current_win()
          end
        end,
        post_open = function(bufnr, winnr, ft, is_blocking)
          -- Hide the terminal so we can see the opened file
          if saved_terminal_win and vim.api.nvim_win_is_valid(saved_terminal_win) then
            vim.api.nvim_win_close(saved_terminal_win, true)
          end
          saved_terminal_win = nil

          -- Focus the newly opened file window in standard Normal mode
          if winnr ~= nil then
            vim.api.nvim_set_current_win(winnr)
          end
        end,
        block_end = function() end,
      },
    }
  end,
}
