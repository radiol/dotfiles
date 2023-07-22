local wezterm = require("wezterm")
local action = wezterm.action

ssh_domains = {
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

unix_domains = { { name = "unix" } }

keys = {
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

return {
	initial_cols = 125,
	initial_rows = 35,
	-- font = wezterm.font_with_fallback({ "JetBrains Mono", "Hack Nerd Font" }),
	font = wezterm.font("UDEV Gothic NF"),
	-- font = wezterm.font("HackGen Console NFJ"),
	font_size = 12,
	use_ime = true,
	color_scheme = "tokyonight",
	window_background_opacity = 0.8,
	macos_window_background_blur = 10,
	send_composed_key_when_left_alt_is_pressed = true,
	ssh_domains = ssh_domains,
	unix_domains = unix_domains,
	default_gui_startup_args = { "connect", "unix" },
	keys = keys,
}
