-- set colorscheme to nightfly with protected call
-- in case it isn't installed
require("tokyonight").setup({
	transparent = true,
	styles = {
		sidebars = "transparent",
		floats = "transparent",
	},
})
local status, _ = pcall(vim.cmd, "colorscheme tokyonight-night")
if not status then
	print("Colorscheme not found!") -- print error if colorscheme not installed
	return
end
