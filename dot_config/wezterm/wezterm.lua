local wezterm = require("wezterm")

ssh_domains = {
	{
		name = "node",
		remote_address = "node",
	},
}

unix_domains = {
	{
		name = "unix",
	},
}

return {
	initial_cols = 100,
	initial_rows = 30,
	font = wezterm.font("JetBrains Mono"),
	use_ime = true,
	color_scheme = "tokyonight",
	window_background_opacity = 0.8,
	send_composed_key_when_left_alt_is_pressed = true,
	ssh_domains = ssh_domains,
	unix_domains = unix_domains,
	default_gui_startup_args = { "connect", "unix" },
}
