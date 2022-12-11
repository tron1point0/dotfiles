local wezterm = require 'wezterm'

-- Pass an input sequence through to the terminal if tmux is the active
-- program running in the pane, otherwise do nothing.
local function if_tmux(text)
  return wezterm.action_callback(function(_, pane)
    if pane:get_foreground_process_info().name == 'tmux' then
      pane:send_text(text)
    end
    -- TODO: Do what would have happened if it weren't tmux
  end)
end

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

  -- Key bindings for tmux integration
  keys = {
    -- <D-[> --> <C-a>[
    { key = '[', mods = 'CMD', action = if_tmux '\x01[' },
    -- <D-]> --> <C-a>]
    { key = ']', mods = 'CMD', action = if_tmux '\x01]' },
    -- <D-t> --> <C-a>c
    { key = 't', mods = 'CMD', action = if_tmux '\x01c' },
    -- <D-Arrows> --> <C-a>Arrows
    { key = 'UpArrow', mods = 'CMD', action = if_tmux '\x01\x1b[A' },
    { key = 'DownArrow', mods = 'CMD', action = if_tmux '\x01\x1b[B' },
    { key = 'RightArrow', mods = 'CMD', action = if_tmux '\x01\x1b[C' },
    { key = 'LeftArrow', mods = 'CMD', action = if_tmux '\x01\x1b[D' },
  }
}

-- Per-host overrides
local overrides = {
  hadar = function()
    config.font_size = 12.0
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
