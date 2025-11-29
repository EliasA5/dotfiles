
local dimmer = { brightness = 0.10 }

local user = os.getenv("USER")

return {
  {
    source = {
      File = '/home/' .. user .. '/Pictures/wezterm_background.jpg',
    },
    hsb = dimmer,
  }
}

