local wezterm = require("wezterm")
local config = wezterm.config_builder()

wezterm.on("format-tab-title", function(tab)
	local process_path = tab.active_pane.foreground_process_name or ""
	local process_name = string.match(process_path, "([^/]+)$") or "Terminal"

	local tab_number = tostring(tab.tab_index + 1)

	return {
		{ Text = " " .. tab_number .. "." .. process_name .. " " },
	}
end)

config.initial_cols = 120
config.initial_rows = 30
config.window_decorations = "RESIZE"
config.enable_wayland = false

config.use_fancy_tab_bar = false

config.cell_width = 1

config.font_size = 10
config.line_height = 1.1
config.freetype_load_target = "Light"
config.freetype_load_flags = "NO_HINTING"

local maple_mono = {
	name = "Maple Mono NF",
	features = {
		"calt",
		"liga",
		"cv01",
		"cv62",
		"cv08",
	},
}

local monolisa = {
	name = "MonoLisa",
	features = {
		"liga",
		"calt",
		"zero",
		"ss02",
		"ss07",
		"ss08",
		"ss11",
		"ss12",
	},
}

local font = maple_mono

config.font = wezterm.font_with_fallback({
	{
		family = font.name,
		weight = 400,
		harfbuzz_features = font.features,
	},
})

config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}

-- config.underline_position = "-5"
config.underline_position = "-4"

config.front_end = "WebGpu"
config.max_fps = 120
config.webgpu_power_preference = "HighPerformance"

local kansoZen = {
	foreground = "#C5C9C7",
	background = "#090E13",

	cursor_fg = "#090E13",
	cursor_bg = "#C5C9C7",
	cursor_border = "#C5C9C7",

	selection_fg = "#C5C9C7",
	selection_bg = "#24262D",

	scrollbar_thumb = "#24262D",
	split = "#24262D",

	ansi = {
		"#090E13",
		"#C4746E",
		"#8A9A7B",
		"#C4B28A",
		"#8BA4B0",
		"#A292A3",
		"#8EA4A2",
		"#A4A7A4",
	},
	brights = {
		"#A4A7A4",
		"#E46876",
		"#87A987",
		"#E6C384",
		"#7FB4CA",
		"#938AA9",
		"#7AA89F",
		"#C5C9C7",
	},
}

local tokyodark = {
	foreground = "#a0a8cd",
	background = "#11121d",

	cursor_bg = "#a0a8cd",
	cursor_fg = "#11121d",
	cursor_border = "#a0a8cd",

	selection_bg = "#11121d",
	selection_fg = "#a0a8cd",

	ansi = {
		"#06080a",
		"#ee6d85",
		"#95c561",
		"#d7a65f",
		"#7199ee",
		"#a485dd",
		"#38a89d",
		"#a0a8cd",
	},
	brights = {
		"#212234",
		"#ee6d85",
		"#95c561",
		"#d7a65f",
		"#7199ee",
		"#a485dd",
		"#38a89d",
		"#a0a8cd",
	},
}

config.force_reverse_video_cursor = false
-- config.colors = tokyodark
config.color_scheme = "Gruvbox Material (Gogh)"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = {
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("CurrentPaneDomain"),
	},

	{
		key = ";",
		mods = "LEADER",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "'",
		mods = "LEADER",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},

	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},

	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},

	{
		key = "1",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = "2",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = "3",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = "4",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(3),
	},
	{
		key = "5",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(4),
	},
	{
		key = "6",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(5),
	},
	{
		key = "7",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(6),
	},
	{
		key = "8",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(7),
	},
	{
		key = "9",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(8),
	},
	{
		key = "0",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(9),
	},

	{
		key = "d",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentTab({ confirm = false }),
	},
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = false }),
	},
	{
		key = "h",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "l",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "k",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "j",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
}

return config
