local wezterm = require 'wezterm'
local act = wezterm.action

local config = {
  -- Options
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  tab_max_width = 24,
  status_update_interval = 200, -- TODO: Reset to default
  use_resize_increments = true,
  window_background_opacity = 0.9,
  cursor_thickness = '0.1cell',
  visual_bell = {
    fade_in_function = 'EaseIn',
    fade_in_duration_ms = 75,
    fade_out_function = 'EaseOut',
    fade_out_duration_ms = 75,
  },
  window_padding = {
    top = 0,
    right = 0,
    bottom = 0,
    left = 0,
  },

  -- Fonts
  font = wezterm.font_with_fallback {
    'JetBrainsMono Nerd Font',
    'FiraCode Nerd Font',
    'Fira Code',
    'Liberation Mono',
    'Menlo'
  },
  font_size = 14.0,

  -- Colors
  color_scheme = "Dark+",

  keys = {
    -- Switch tabs with Cmd-[]
    { key = '[', mods = 'CMD', action = act.ActivateTabRelative(-1) },
    { key = ']', mods = 'CMD', action = act.ActivateTabRelative(1) },
    -- Split panes
    { key = 'h', mods = 'CMD|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
    { key = 'v', mods = 'CMD|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },
    -- For Linux hosts
    { key = ',', mods = 'CMD', action = wezterm.action.SplitPane { direction = 'Down' } },
    { key = "'", mods = 'CMD', action = wezterm.action.SplitPane { direction = 'Right' } },
  },
}

-- Per-host overrides
local overrides = {
  hadar = function()
    config.font_size = 12.0
    config.freetype_load_target = "HorizontalLcd"
    config.freetype_render_target = "HorizontalLcd"
  end,
}

-- {{{ Apply per-host overrides

local hostname = wezterm.hostname()
for host, fn in pairs(overrides) do
  if hostname == host then
    fn()
    break
  end
end

-- }}}

--- {{{ Statusbar contents and colors
wezterm.GLOBAL.username = (function()
  local _, value, _ = wezterm.run_child_process { 'whoami' }
  return value:gsub("%s", "")
end)()

wezterm.on('update-status', function(window, pane)
  local username = wezterm.GLOBAL.username
  local hostname = wezterm.hostname()
  local time = wezterm.strftime '%H:%M'

  local offset = config.tab_and_split_indices_are_zero_based and 0 or 1
  local tab_index = 0
  for _, t in pairs(window:mux_window():tabs_with_info()) do
    if t.is_active then
      tab_index = t.index + offset
      break
    end
  end

  local pane_index = 0
  for _, p in pairs(pane:tab():panes_with_info()) do
    if p.is_active then
      pane_index = p.index + offset
      break
    end
  end

  local left_border = wezterm.nerdfonts.ple_lower_left_triangle
  local right_border = wezterm.nerdfonts.ple_lower_right_triangle
  if not config.tab_bar_at_bottom then
    left_border = wezterm.nerdfonts.ple_upper_left_triangle
    right_border = wezterm.nerdfonts.ple_upper_right_triangle
  end

  window:set_left_status(wezterm.format {
    { Foreground = { Color = '#000000' } },
    { Background = { Color = '#5fd787' } },
    { Text = ' ' .. window:window_id() .. ':' .. tab_index .. '.' .. pane_index .. ' ' },
    'ResetAttributes',
    { Foreground = { Color = '#5fd787' } },
    { Text = left_border }
  })

  window:set_right_status(wezterm.format {
    'ResetAttributes',
    { Foreground = { Color = '#444444' } },
    { Text = right_border },
    { Foreground = { AnsiColor = 'Silver' } },
    { Background = { Color = '#444444' } },
    { Text = ' ' .. username },
    { Foreground = { Color = '#6c6c6c' } },
    { Text = '@' },
    { Foreground = { AnsiColor = 'Silver' } },
    { Text = hostname .. ' ' },
    { Foreground = { Color = '#0087ff' } },
    { Text = right_border },
    { Foreground = { Color = 'white' } },
    { Background = { Color = '#0087ff' } },
    { Text = ' ' .. time .. ' ' },
  })
end)

wezterm.on('format-tab-title', function(tab, _, _, cfg, _, max_width)
  -- One space on either side for the \/
  -- One space on either side for padding
  -- One space for the status indicator
  -- == 2 + 2 + 1 == 5
  local width_offset = 5
  local tab_offset = cfg.tab_and_split_indices_are_zero_based and 0 or 1
  local tab_index = (tab.tab_index + tab_offset) .. ''
  width_offset = width_offset + tab_index:len()

  local left_border = wezterm.nerdfonts.ple_lower_left_triangle
  local right_border = wezterm.nerdfonts.ple_lower_right_triangle
  if not config.tab_bar_at_bottom then
    left_border = wezterm.nerdfonts.ple_upper_left_triangle
    right_border = wezterm.nerdfonts.ple_upper_right_triangle
  end
  if config.use_fancy_tab_bar then
    left_border = ''
    right_border = ''
  end

  -- if cfg.show_tab_index_in_tab_bar then
  --   -- TODO
  -- end

  local title = tab.active_pane.title
  title = wezterm.truncate_right(title, max_width - width_offset)

  if tab.is_active then
    return {
      { Background = { Color = '#000000' } },
      { Foreground = { Color = '#333333' } },
      { Text = left_border },
      'ResetAttributes',
      { Text = ' ' },
      { Foreground = { Color = '#585858' } },
      { Text = tab_index },
      'ResetAttributes',
      { Foreground = { Color = '#ffaf00' } },
      { Text = '*' },
      'ResetAttributes',
      { Foreground = { AnsiColor = 'Silver' } },
      { Text = title },
      { Text = ' ' },
      'ResetAttributes',
      { Background = { Color = '#000000' } },
      { Foreground = { Color = '#333333' } },
      { Text = right_border },
    }
  end

  if tab.active_pane.has_unseen_output then
    return {
      { Text = '  ' },
      { Foreground = { Color = '#585858' } },
      { Text = tab_index },
      { Foreground = { AnsiColor = 'Yellow' } },
      { Text = '#' },
      'ResetAttributes',
      { Text = title },
      { Text = '  ' },
    }
  end

  -- TODO: Handle last active tab

  return {
    { Text = '  ' },
    { Text = tab_index },
    { Text = '.' },
    'ResetAttributes',
    { Text = title },
    { Text = '  ' },
  }
end)
-- }}}

return config
