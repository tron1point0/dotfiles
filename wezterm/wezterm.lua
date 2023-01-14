local wezterm = require 'wezterm'
local act = wezterm.action

local config = {
  -- Options
  hide_tab_bar_if_only_one_tab = true,
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

return config
