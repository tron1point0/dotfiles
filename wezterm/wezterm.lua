local wezterm = require 'wezterm'

local config = {
  -- Options
  hide_tab_bar_if_only_one_tab = true,
  use_resize_increments = true,
  window_background_opacity = 0.9,
  cursor_thickness = '4px',
  underline_thickness = '3px',
  window_padding = {
    top = 0,
    right = 0,
    bottom = 0,
    left = 0,
  },

  -- Fonts
  font = wezterm.font_with_fallback {
    'FiraCode Nerd Font',
    'Fira Code',
    'Menlo'
  },
  font_size = 14,

  -- Colors
  -- color_scheme = 'OneDark (base16)',
  -- color_scheme = 'nord',
  -- color_scheme = 'AyuDark (Gogh)',
  color_scheme = 'ayu',
  -- color_scheme = 'Terminal.app',
  color_schemes = {
    -- {{{ Custom color schemes
    ['Terminal.app'] = {
      background = '#000000',
      foreground = '#b6b6b6',
      ansi = {
        '#000000',
        '#990000',
        '#00a600',
        '#999900',
        '#005fff',
        '#b200b2',
        '#00a6b2',
        '#bfbfbf',
      },
      brights = {
        '#666666',
        '#e50000',
        '#00d900',
        '#e5e500',
        '#0087ff',
        '#e500e5',
        '#00e5e5',
        '#e5e5e5',
      },
    }
    -- }}}
  },
}

return config
