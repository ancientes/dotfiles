local wezterm = require("wezterm")
local config  = wezterm.config_builder()

-- Font
config.font = wezterm.font_with_fallback({
  "FiraCode Nerd Font",
})
config.font_size = 13.0
config.harfbuzz_features = { "liga", "calt", "ss01" }

-- Terminal
config.term = "xterm-256color"

-- Hold Shift to bypass app mouse reporting (default, but good to be explicit)
config.bypass_mouse_reporting_modifiers = "SHIFT"

-- Performance
config.max_fps = 120
config.prefer_egl = true

-- Window title (blank but keeps draggable bar)
config.window_decorations = "RESIZE"
config.enable_tab_bar = false
config.window_frame = {
  font_size = 12.0,
}

-- Disable close confirmation
config.skip_close_confirmation_for_processes_named = { "bash", "zsh", "fish" }
config.window_close_confirmation = "NeverPrompt"

-- Scrollback
config.scrollback_lines = 100000

-- Cursor
config.default_cursor_style = "SteadyBlock"  -- Ghostty's default cursor style

config.colors = {
  cursor_bg = "#f4d900",
  cursor_fg = "#ffffff",

  -- General colors
  background = "#1E1D2F",
  foreground = "#ffffff",

  -- Selection
  selection_bg = "#1f454a",
  selection_fg = "#c2c2c2",

  -- ANSI colors (Cobalt2 derived)
  ansi = {
    "#000000", "#ff2626", "#3ce062", "#f4d300",
    "#1478db", "#ff2b70", "#00c5c5", "#c7c7c7",
  },
  brights = {
    "#686868", "#f92a1a", "#43d426", "#f1d000",
    "#6872ff", "#ff77ff", "#79e8fb", "#ffffff",
  },
}

-- Window size approximation (in cells)
config.initial_cols = 140
config.initial_rows = 40

-- Padding
config.window_padding = {
  left = 28,
  right = 18,
  top = 50,
  bottom = 14,
}

-- Mouse wheel behavior
config.mouse_wheel_scrolls_tabs = false  -- Equivalent to Ghostty's direct scroll behavior

-- Clipboard
config.enable_kitty_graphics = true
config.enable_kitty_keyboard = true

-- macOS Option key
config.send_composed_key_when_left_alt_is_pressed = true
config.send_composed_key_when_right_alt_is_pressed = true

return config
