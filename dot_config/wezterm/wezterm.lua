local wezterm = require("wezterm")

return {
	initial_cols = 100,
	initial_rows = 30,
	font = wezterm.font("JetBrains Mono"),
	use_ime = true,
	color_scheme = "tokyonight",
	window_background_opacity = 0.8,
	send_composed_key_when_left_alt_is_pressed = true,
}
