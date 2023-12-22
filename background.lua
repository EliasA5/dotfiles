
local dimmer = { brightness = 0.10 }

local user = os.getenv("USER")

return {
  {
    source = {
      File = '/home/' .. user .. '/Pictures/wallhaven-kx98xd_1920x1080.png',
    },
    hsb = dimmer,
  }
}

