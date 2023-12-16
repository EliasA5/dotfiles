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
  wez.log_info('inside tmux: ' .. prog)
  return prog == 'tmux'
end

local function is_outside_tmux(pane) return not is_inside_tmux(pane) end

local function and_2_functions(f1, f2)
  return (function(pane)
    local cond1 = f1(pane)
    return cond1 and f2(pane)
  end)
end

return {
  {
    key = 'v',
    mods = 'LEADER',
    action = act.SplitPane {
      direction = 'Right',
      size = { Percent = 40 },
    },
  },
   bind_if(is_outside_tmux, 'h', 'LEADER', act.SplitVertical({domain = 'CurrentPaneDomain' })),
   bind_if(is_outside_tmux, 'x', 'LEADER', act.CloseCurrentPane({confirm = true })),
   bind_if(is_outside_tmux, 'c', 'LEADER', act.SpawnTab('CurrentPaneDomain')),
   bind_if(is_outside_tmux, 'm', 'LEADER', act.TogglePaneZoomState),
   bind_if(is_outside_tmux, 'd', 'LEADER', act.Nop),
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
   bind_if(is_outside_tmux, 'LeftArrow', 'LEADER', act.AdjustPaneSize({'Left', 5})),
   bind_if(is_outside_tmux, 'DownArrow', 'LEADER', act.AdjustPaneSize({'Down', 5})),
   bind_if(is_outside_tmux, 'UpArrow', 'LEADER', act.AdjustPaneSize({'Up', 5})),
   bind_if(is_outside_tmux, 'RightArrow', 'LEADER', act.AdjustPaneSize({'Right', 5})),
  {
    key = 'RightArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(1)
  },
  {
    key = 'LeftArrow',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(-1)
  },
  {
    key = 'l',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(1)
  },
  {
    key = 'h',
    mods = 'CTRL|SHIFT',
    action = act.ActivateTabRelative(-1)
  },
  {
    key = 'l',
    mods = 'LEADER',
    action = act.ShowLauncher,
  },
   bind_if(and_2_functions(is_outside_tmux, is_outside_vim), 'h', 'CTRL', act.ActivatePaneDirection('Left')),
   bind_if(and_2_functions(is_outside_tmux, is_outside_vim), 'l', 'CTRL', act.ActivatePaneDirection('Right')),
   bind_if(and_2_functions(is_outside_tmux, is_outside_vim), 'j', 'CTRL', act.ActivatePaneDirection('Down')),
   bind_if(and_2_functions(is_outside_tmux, is_outside_vim), 'k', 'CTRL', act.ActivatePaneDirection('Up')),
}
