local wezterm = require 'wezterm'

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
}

-- {{{ Per-host overrides
local overrides = {
  hadar = function()
    config.font_size = 12.0
  end,
}

local hostname = wezterm.hostname()
for host, fn in pairs(overrides) do
  if hostname == host then
    fn()
    break
  end
end
-- }}}

return config
