local wezterm = require 'wezterm'
local config = {}
local wez = wezterm
local act = wezterm.action

config.font = wezterm.font('FiraCode Nerd Font Mono', {weight = "Regular", stretch = "Normal", italic = false})

local function is_inside_vim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then return false end

  local success, stdout, stderr = wez.run_child_process
    { 'sh', '-c',
      'ps -o state= -o comm= -t' .. wez.shell_quote_arg(tty) .. ' | ' ..
      'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$\'' }

  return success
end

local function is_outside_vim(pane) return not is_inside_vim(pane) end

local function bind_if(cond, key, mods, action)
  local function callback (win, pane)
    if cond(pane) then
      win:perform_action(action, pane)
    else
      win:perform_action(act.SendKey({key=key, mods=mods}), pane)
    end
  end

  return {key=key, mods=mods, action=wez.action_callback(callback)}
end

-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = 'Space', mods = 'CTRL', timeout_milliseconds = 1000 }
config.keys = {
  {
    key = 'v',
    mods = 'LEADER',
    action = act.SplitPane { direction = 'Right',
                                        size = { Percent = 40 },
                                      },
},
  {
    key = 'h',
    mods = 'LEADER',
    action = act.SplitVertical { domain = 'CurrentPaneDomain' },
  },
  {
    key = 'c',
    mods = 'LEADER',
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = 'm',
    mods = 'LEADER',
    action = act.TogglePaneZoomState,
  },
  {
    key = 'Space',
    mods = 'LEADER',
    action = act.SendKey { key = 'Space', mods = 'CTRL' },
  },
  {
    key = 'r',
    mods = 'LEADER',
    action = act.ReloadConfiguration,
  },
  bind_if(is_outside_vim, 'h', 'CTRL', act.ActivatePaneDirection('Left')),
  bind_if(is_outside_vim, 'l', 'CTRL', act.ActivatePaneDirection('Right')),
  bind_if(is_outside_vim, 'j', 'CTRL', act.ActivatePaneDirection('Down')),
  bind_if(is_outside_vim, 'k', 'CTRL', act.ActivatePaneDirection('Up')),
  {
    key = 'LeftArrow',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Left', 5 },
  },
  {
    key = 'DownArrow',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Down', 5 },
  },
  {
    key = 'UpArrow',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Up', 5 }
  },
  {
    key = 'RightArrow',
    mods = 'LEADER',
    action = act.AdjustPaneSize { 'Right', 5 },
  },
}


local dimmer = { brightness = 0.04 }

config.enable_scroll_bar = true
config.min_scroll_bar_height = '2cell'
config.colors = {
  scrollbar_thumb = 'white',
}

config.background = {
  {
    source = {
      File = '/home/elias/Pictures/wallhaven-kx98xd_1920x1080.png',
    },
    hsb = dimmer,
  }
}

return config
