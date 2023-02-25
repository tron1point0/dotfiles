local wezterm = require 'wezterm'
local act = wezterm.action

local color_scheme = "Dark+"

-- {{{ Palette for matching UI elements with terminal colorscheme

local palette = wezterm.get_builtin_color_schemes()[color_scheme]
palette.grey = wezterm.color.gradient({
  colors = { palette.background, palette.foreground },
  interpolation = 'Linear',
  blend = 'Hsv',
}, 7)
for i, c in ipairs({
  "black",
  "red",
  "green",
  "yellow",
  "blue",
  "magenta",
  "cyan",
  "white",
}) do
  palette[c] = palette.ansi[i]
end

-- }}}

local config = {
  -- Options
  hide_tab_bar_if_only_one_tab = true,
  use_fancy_tab_bar = false,
  tab_bar_at_bottom = true,
  tab_max_width = 24,
  colors = {
    tab_bar = {
      background = palette.grey[2],
      active_tab = {
        fg_color = palette.foreground,
        bg_color = palette.background,
      },
      inactive_tab = {
        fg_color = palette.grey[5],
        bg_color = palette.grey[2],
      },
      new_tab = {
        fg_color = palette.grey[5],
        bg_color = palette.grey[2],
      },
    },
  },
  window_frame = {
    active_titlebar_bg = palette.grey[2],
    inactive_titlebar_bg = palette.grey[2],
  },
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
  color_scheme = color_scheme,
  keys = {
    -- Switch tabs with Cmd-[]
    { key = '[', mods = 'CMD',       action = act.ActivateTabRelative( -1) },
    { key = ']', mods = 'CMD',       action = act.ActivateTabRelative(1) },
    -- Split panes
    { key = 'h', mods = 'CMD|SHIFT', action = wezterm.action.SplitPane { direction = 'Down' } },
    { key = 'v', mods = 'CMD|SHIFT', action = wezterm.action.SplitPane { direction = 'Right' } },
    -- For Linux hosts
    { key = ',', mods = 'CMD',       action = wezterm.action.SplitPane { direction = 'Down' } },
    { key = "'", mods = 'CMD',       action = wezterm.action.SplitPane { direction = 'Right' } },
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

-- {{{ Statusbar contents and colors

local username = (function()
      local _, value, _ = wezterm.run_child_process { 'whoami' }
      return value:gsub("%s", "")
    end)()

local left_border = wezterm.nerdfonts.ple_lower_left_triangle
local right_border = wezterm.nerdfonts.ple_lower_right_triangle
if not config.tab_bar_at_bottom then
  left_border = wezterm.nerdfonts.ple_upper_left_triangle
  right_border = wezterm.nerdfonts.ple_upper_right_triangle
end

wezterm.on('update-status', function(window, pane)
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

  window:set_left_status(wezterm.format {
    { Foreground = { Color = palette.grey[2] } },
    { Background = { Color = palette.green } },
    { Text = ' ' .. window:window_id() .. ':' .. tab_index .. '.' .. pane_index .. ' ' },
    'ResetAttributes',
    { Foreground = { Color = palette.green } },
    { Text = left_border }
  })

  window:set_right_status(wezterm.format {
    'ResetAttributes',
    { Foreground = { Color = palette.grey[3] } },
    { Text = right_border },
    { Foreground = { Color = palette.foreground } },
    { Background = { Color = palette.grey[3] } },
    { Text = ' ' .. username },
    { Foreground = { Color = palette.grey[4] } },
    { Text = '@' },
    { Foreground = { Color = palette.foreground } },
    { Text = hostname .. ' ' },
    { Foreground = { Color = palette.blue } },
    { Text = right_border },
    { Foreground = { Color = palette.foreground } },
    { Background = { Color = palette.blue } },
    { Text = ' ' .. time .. ' ' },
  })
end)

wezterm.on('format-tab-title', function(tab, _, _, _, _, max_width)
  local tab_offset = config.tab_and_split_indices_are_zero_based and 0 or 1
  local tab_index = (tab.tab_index + tab_offset) .. ''

  local tab_left_border = left_border
  local tab_right_border = right_border
  if config.use_fancy_tab_bar then
    tab_left_border = ' '
    tab_right_border = ' '
  end
  -- These must be the same lengths as `tab_left_border`
  local tab_left_no_border = ' '
  local tab_right_no_border = ' '

  local tab_left_padding = ' '
  local tab_right_padding = ' '

  -- if cfg.show_tab_index_in_tab_bar then
  --   -- TODO
  -- end

  local title = tab.active_pane.title
  if not config.use_fancy_tab_bar then
    local width_offset = 0
    for _, s in ipairs({
      tab_left_no_border,
      tab_left_padding,
      tab_index,
      '*',
      tab_right_padding,
      tab_right_no_border,
    }) do
      width_offset = width_offset + s:len()
    end
    title = wezterm.truncate_right(title, max_width - width_offset)
  end

  if tab.is_active then
    return {
      { Foreground = { Color = palette.grey[2] } },
      { Text = tab_left_border },
      { Text = tab_left_padding },
      { Foreground = { Color = palette.grey[5] } },
      { Text = tab_index },
      { Foreground = { Color = palette.yellow } },
      { Text = '*' },
      'ResetAttributes',
      { Text = title },
      { Text = tab_right_padding },
      { Foreground = { Color = palette.grey[2] } },
      { Text = tab_right_border },
    }
  end

  if tab.active_pane.has_unseen_output then
    return {
      { Text = tab_left_no_border },
      { Text = tab_left_padding },
      { Text = tab_index },
      { Foreground = { Color = palette.yellow } },
      { Text = '#' },
      'ResetAttributes',
      { Text = title },
      { Text = tab_right_padding },
      { Text = tab_right_no_border },
    }
  end

  -- TODO: Handle last active tab

  return {
    { Text = tab_left_no_border },
    { Text = tab_left_padding },
    { Text = tab_index },
    { Text = '.' },
    { Text = title },
    { Text = tab_right_padding },
    { Text = tab_right_no_border },
  }
end)
-- }}}

return config
