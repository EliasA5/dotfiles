local wezterm = require('wezterm')
local config = {}
local act = wezterm.action

config.font = wezterm.font(
  'FiraCode Nerd Font Mono',
  {
    weight = "Regular",
    stretch = "Normal",
    italic = false
  }
)

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = {
  key = 'Space',
  mods = 'CTRL',
  timeout_milliseconds = 1000
}
config.keys = require("keys")

local nvim_integ = require("nvim_intergration")
nvim_integ.add_keybinds(config)

config.enable_scroll_bar = true
config.min_scroll_bar_height = '2cell'
config.colors = {
  scrollbar_thumb = 'white',
}

config.background = require("background")
local status_bar = require("status_bar")
status_bar.apply_to_config(config)

config.default_cursor_style = 'SteadyBlock'

return config
