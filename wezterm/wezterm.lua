local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- window
config.initial_cols = 120
config.initial_rows = 28
config.window_padding = { left = 12, right = 12, top = 12, bottom = 12 }
config.window_decorations = "TITLE | RESIZE"
config.window_background_opacity = 0.96

-- font
config.font = wezterm.font("FiraCode Nerd Font", { weight = "Medium" })
config.font_size = 14.0
config.line_height = 1.15

-- cursor
config.default_cursor_style = "BlinkingBar"
config.cursor_blink_rate = 500

-- tab bar
config.hide_tab_bar_if_only_one_tab = true
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false

-- tinacious design color scheme
config.colors = {
  foreground = "#cccccc",
  background = "#222431",
  cursor_bg = "#f85b9e",
  cursor_fg = "#1d1e26",
  cursor_border = "#f85b9e",
  selection_fg = "#ffffff",
  selection_bg = "#3c4c72",
  ansi = {
    "#1d1e26", -- black
    "#f9345e", -- red
    "#2ec84a", -- green
    "#e7de40", -- yellow
    "#3c7dd2", -- blue
    "#f85b9e", -- magenta
    "#29b8db", -- cyan
    "#cccccc", -- white
  },
  brights = {
    "#636363", -- bright black
    "#ff6b81", -- bright red
    "#69f090", -- bright green
    "#fff47d", -- bright yellow
    "#6cb4ff", -- bright blue
    "#ff8ec4", -- bright magenta
    "#6ce5f8", -- bright cyan
    "#ffffff", -- bright white
  },
  tab_bar = {
    background = "#16171e",
    active_tab = { bg_color = "#1d1e26", fg_color = "#f85b9e" },
    inactive_tab = { bg_color = "#16171e", fg_color = "#636363" },
    inactive_tab_hover = { bg_color = "#1d1e26", fg_color = "#cccccc" },
    new_tab = { bg_color = "#16171e", fg_color = "#636363" },
    new_tab_hover = { bg_color = "#1d1e26", fg_color = "#f85b9e" },
  },
}

-- launch nix dev shell via direnv on startup
config.default_cwd = wezterm.home_dir .. "/code"
config.default_prog = { "zsh" }


return config
