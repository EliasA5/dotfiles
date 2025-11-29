return {
  'ggandor/leap.nvim',
  lazy = false,
  keys = {
    {
      "s", function()
        require('leap').leap({target_windows = {vim.api.nvim_get_current_win()}})
      end,
      {"n", "x", "o"},
    }
  }
}

