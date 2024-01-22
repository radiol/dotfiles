local wezterm = require("wezterm")
local action = wezterm.action

local ssh_domains = {
	{
		name = "node202",
		remote_address = "node",
	},
	{
		name = "lan",
		remote_address = "lan",
	},
	{
		name = "wan",
		remote_address = "wan",
	},
}

local unix_domains = { { name = "unix" } }

local keys = {
	-- CMD + w: Close tab.
	{
		key = "w",
		mods = "CMD",
		action = action.CloseCurrentTab({ confirm = false }),
	},
	-- Alt + h: Horizontal split(Left/Right).
	{
		key = "h",
		mods = "ALT",
		action = action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- Alt + v: Vertical split(Top/Bottom).
	{
		key = "v",
		mods = "ALT",
		action = action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
}

local config = {}
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- color_scheme
config.color_scheme = "Catppuccin Frappe"
-- if wezterm.target_triple == "aarch64-apple-darwin" then
-- 	config.color_scheme = "Catppuccin Frappe"
-- elseif wezterm.target_triple == "x86_64-unknown-linux-gnu" then
-- 	config.color_scheme = "Dracula (base16)"
-- end

-- window size
config.initial_cols = 125
config.initial_rows = 35
-- font
config.font = wezterm.font("UDEV Gothic NF")
config.font_size = 14
config.use_ime = true
-- window background
config.window_background_opacity = 0.8
config.macos_window_background_blur = 10
config.send_composed_key_when_left_alt_is_pressed = true
-- ssh, unix domain
config.ssh_domains = ssh_domains
config.unix_domains = unix_domains
config.default_gui_startup_args = { "connect", "unix" }
-- keys
config.keys = keys

return config
