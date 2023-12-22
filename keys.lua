local wez = require('wezterm')
local act = wez.action

local function is_inside_vim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then return false end

  local success, stdout, stderr = wez.run_child_process
    { 'sh', '-c',
      'ps -o state= -o comm= -t' .. wez.shell_quote_arg(tty) .. ' | ' ..
      'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$\'' }

  wez.log_info('inside vim: ' .. tostring(success))
  return success
end

local function is_outside_vim(pane) return not is_inside_vim(pane) end

local function bind_if(cond, key, mods, action)
  local function callback (win, pane)
    if cond(pane) then
      win:perform_action(action, pane)
    else
      if mods == 'LEADER' then
        win:perform_action(act.SendKey({key='Space', mods='CTRL'}), pane)
        win:perform_action(act.SendKey({key=key}), pane)
      else
        win:perform_action(act.SendKey({key=key, mods=mods}), pane)
      end
    end
  end

  return {key=key, mods=mods, action=wez.action_callback(callback)}
end

local function basename(s)
  return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

local function is_inside_tmux(pane)
  local name = pane:get_foreground_process_name()
  if name == nil then return false end
  local prog = basename(name)
  -- wez:log_info(prog == 'tmux')
  -- wez.log_info('inside tmux: ' .. prog)
  return prog == 'tmux'
end

local function is_outside_tmux(pane) return not is_inside_tmux(pane) end

passthrough = true

local function is_passthrough(pane) return passthrough end
local function isnt_passthrough(pane) return not passthrough end
local function toggle_passthrough() passthrough = not passthrough end

local function and_2_functions(f1, f2)
  return (function(pane)
    local cond1 = f1(pane)
    return cond1 and f2(pane)
  end)
end

return {
   bind_if(isnt_passthrough, 'v', 'LEADER', act.SplitPane ({direction = 'Right', size = { Percent = 40 }, })),
   bind_if(isnt_passthrough, 'h', 'LEADER', act.SplitVertical({domain = 'CurrentPaneDomain' })),
   bind_if(isnt_passthrough, 'x', 'LEADER', act.CloseCurrentPane({confirm = true })),
   bind_if(isnt_passthrough, 'c', 'LEADER', act.SpawnTab('CurrentPaneDomain')),
   bind_if(isnt_passthrough, 'm', 'LEADER', act.TogglePaneZoomState),
   bind_if(isnt_passthrough, 'd', 'LEADER', act.Nop),
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
   bind_if(isnt_passthrough, 'LeftArrow', 'LEADER', act.AdjustPaneSize({'Left', 5})),
   bind_if(isnt_passthrough, 'DownArrow', 'LEADER', act.AdjustPaneSize({'Down', 5})),
   bind_if(isnt_passthrough, 'UpArrow', 'LEADER', act.AdjustPaneSize({'Up', 5})),
   bind_if(isnt_passthrough, 'RightArrow', 'LEADER', act.AdjustPaneSize({'Right', 5})),
   bind_if(isnt_passthrough, 'RightArrow', 'CTRL', act.ActivateTabRelative(1)),
   bind_if(isnt_passthrough, 'LeftArrow', 'CTRL', act.ActivateTabRelative(-1)),
   bind_if(isnt_passthrough, 'RightArrow', 'CTRL|SHIFT', act.Nop),
   bind_if(isnt_passthrough, 'LeftArrow', 'CTRL|SHIFT', act.Nop),
   -- bind_if(isnt_passthrough, 'L', 'CTRL|SHIFT', act.ActivateTabRelative(1)),
   -- bind_if(isnt_passthrough, 'H', 'CTRL|SHIFT', act.ActivateTabRelative(-1)),
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ShowLauncher,
  },
   bind_if(isnt_passthrough, 'h', 'CTRL', act.ActivatePaneDirection('Left')),
   bind_if(isnt_passthrough, 'l', 'CTRL', act.ActivatePaneDirection('Right')),
   bind_if(isnt_passthrough, 'j', 'CTRL', act.ActivatePaneDirection('Down')),
   bind_if(isnt_passthrough, 'k', 'CTRL', act.ActivatePaneDirection('Up')),
  {
    key = 'p',
    mods = 'LEADER',
    action = wez.action_callback(function(_,_)
      toggle_passthrough()
      -- wezterm.log_info(passthrough)
    end),
  },
}
