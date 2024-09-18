-- Create essential variables for configuration
local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Readjust font size on window resize to get rid of the padding at the bottom
function readjust_font_size(window, pane)
	local window_dims = window:get_dimensions()
	local pane_dims = pane:get_dimensions()

	local config_overrides = {}
	local initial_font_size = 13 -- Set to your desired font size
	config_overrides.font_size = initial_font_size

	local max_iterations = 5
	local iteration_count = 0
	local tolerance = 3

	-- Calculate the initial difference between window and pane heights
	local current_diff = window_dims.pixel_height - pane_dims.pixel_height
	local min_diff = math.abs(current_diff)
	local best_font_size = initial_font_size

	-- Loop to adjust font size until the difference is within tolerance or max iterations reached
	while current_diff > tolerance and iteration_count < max_iterations do
		-- wezterm.log_info(window_dims, pane_dims, config_overrides.font_size)
		wezterm.log_info(
			string.format(
				"Win Height: %d, Pane Height: %d, Height Diff: %d, Curr Font Size: %.2f, Cells: %d, Cell Height: %.2f",
				window_dims.pixel_height,
				pane_dims.pixel_height,
				window_dims.pixel_height - pane_dims.pixel_height,
				config_overrides.font_size,
				pane_dims.viewport_rows,
				pane_dims.pixel_height / pane_dims.viewport_rows
			)
		)

		-- Increment the font size slightly
		config_overrides.font_size = config_overrides.font_size + 0.5
		window:set_config_overrides(config_overrides)

		-- Update dimensions after changing font size
		window_dims = window:get_dimensions()
		pane_dims = pane:get_dimensions()
		current_diff = window_dims.pixel_height - pane_dims.pixel_height

		-- Check if the current difference is the smallest seen so far
		local abs_diff = math.abs(current_diff)
		if abs_diff < min_diff then
			min_diff = abs_diff
			best_font_size = config_overrides.font_size
		end

		iteration_count = iteration_count + 1
	end

	-- If no acceptable difference was found, set the font size to the best one encountered
	if current_diff > tolerance then
		config_overrides.font_size = best_font_size
		window:set_config_overrides(config_overrides)
	end
end

-- Pulls a random image's path from the defined folder and returns it
function randomize_image()
	local directory = wezterm.home_dir .. '/.config/wezterm/backgrounds/'
	local images = {}
	for fName in io.popen("ls " .. directory):lines() do
		table.insert(images, directory .. fName)
	end
	return images[math.random(1, #images)]
end

-- Toggle Backgrounds
function toggle_background(window, pane)
	local overrides = window:get_config_overrides() or {}
	if not overrides.window_background_opacity then
		overrides.window_background_opacity = 1
		overrides.background = {
			-- Source image pulled from files
			{
				source = {
					File = randomize_image(),
				},
				hsb = {
					hue = 1.0,
					saturation = 1.02,
					brightness = 0.25,
				},

				width = "100%",
				height = "100%",
			},

			-- A slight gray tinge to help image blend
			{
				source = {
					Color = "#282c35",
				},

				width = "100%",
				height = "100%",
				opacity = 0.55,
			}
		}
	else
		overrides.window_background_opacity = nil
		overrides.background = nil
	end
	window:set_config_overrides(overrides)
end

-- Main configurations
config = {
	automatically_reload_config = true,
	enable_tab_bar = false,
	window_decorations = "RESIZE",
	default_cursor_style = "BlinkingBar",
	color_scheme = "Catppuccin Mocha (Gogh)",

	-- Key to toggle background (Hitting key will grab a BG)
	keys = {
		{
			key = "B",
			mods = "CTRL",
			action = wezterm.action.EmitEvent "toggle-opacity",
		},
	},

	-- Padding for edges
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},

	-- configures fonts to fit screen
	font = wezterm.font("JetBrains Mono", { weight = "Bold" }),
	font_size = 12.5,
}

-- Each time the window is resized, adjust font size to reduce bottom padding
wezterm.on("window-resized", function(window, pane)
	readjust_font_size(window, pane)
end)

-- Enables a transparent BG for images
wezterm.on("toggle-opacity", function(window, pane)
	toggle_background(window, pane)
end)

return config
