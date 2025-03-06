return {
  'numToStr/Navigator.nvim',
  lazy = false,
  keys = {
    {'<C-h>', '<CMD>NavigatorLeft<CR>', {'n', 't'}},
    {'<C-l>', '<CMD>NavigatorRight<CR>', {'n', 't'}},
    {'<C-j>', '<CMD>NavigatorDown<CR>', 'n'},
    {'<C-k>', '<CMD>NavigatorUp<CR>', 'n'},
  },
  opts = {
    -- Save modified buffer(s) when moving to mux
    -- nil - Don't save (default)
    -- 'current' - Only save the current modified buffer
    -- 'all' - Save all the buffers
    auto_save = nil,

    -- Disable navigation when the current mux pane is zoomed in
    disable_on_zoom = true,

    -- Multiplexer to use
    -- 'auto' - Chooses mux based on priority (default)
    -- table - Custom mux to use
    mux = 'auto'
  }
}

