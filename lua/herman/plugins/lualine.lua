local dracula = require("dracula")
local colors = dracula.colors()

local lualine_dracula = require("lualine.themes.dracula-nvim")
local copilot_colors = {
	[""] = { fg = colors.grey, bg = colors.none },
	["Normal"] = { fg = colors.grey, bg = colors.none },
	["Warning"] = { fg = colors.red, bg = colors.none },
	["InProgress"] = { fg = colors.yellow, bg = colors.none },
}

lualine_dracula.normal.c.bg = colors.none
lualine_dracula.insert.c.bg = colors.none
lualine_dracula.replace.c.bg = colors.none

lualine_dracula.normal.a.bg = colors.none
lualine_dracula.normal.a.fg = colors.purple
lualine_dracula.normal.b.bg = colors.none
lualine_dracula.normal.b.fg = colors.purple

lualine_dracula.insert.a.bg = colors.none
lualine_dracula.insert.a.fg = colors.orange
lualine_dracula.insert.b.bg = colors.none
lualine_dracula.insert.b.fg = colors.purple

lualine_dracula.visual.a.bg = colors.none
lualine_dracula.visual.a.fg = colors.yellow
lualine_dracula.visual.b.bg = colors.none
lualine_dracula.visual.b.fg = colors.purple

lualine_dracula.replace.a.bg = colors.none
lualine_dracula.replace.a.fg = colors.cyan
lualine_dracula.replace.b.bg = colors.none
lualine_dracula.replace.b.fg = colors.purple

lualine_dracula.command.a.bg = colors.none
lualine_dracula.command.a.fg = colors.red
lualine_dracula.command.b.bg = colors.none
lualine_dracula.command.b.fg = colors.purple

require("lualine").setup({
	options = {
		component_separators = { left = " ", right = " " },
		section_separators = { left = " ", right = " " },
		theme = lualine_dracula,
		globalstatus = true,
		disabled_filetypes = { statusline = { "dashboard", "alpha", "NvimTree" } },
	},
	sections = {
		lualine_a = {
			{ "mode", icon = "" },
		},
		lualine_b = {
			{
				"filetype",
				icon_only = true,
				separator = "",
				padding = { left = 1, right = 0 },
				color = { fg = colors.grey, bg = "#292A35" },
			},
			{
				"filename",
				symbols = { modified = "  ", readonly = " readonly", unnamed = "" },
				color = { fg = colors.grey, bg = "#292A35" },
			},
		},
		lualine_c = {
			{
				"diagnostics",
				symbols = {
					error = " ",
					warn = " ",
					info = " ",
					hint = "󰝶 ",
				},
				color = { fg = colors.grey, bg = "#292A35" },
			},
		},
		lualine_x = {
			{
				function()
					local icon = " "
					local status = require("copilot.api").status.data
					return icon .. (status.message or "")
				end,
				cond = function()
					local ok, clients = pcall(vim.lsp.get_active_clients, { name = "copilot", bufnr = 0 })
					return ok and #clients > 0
				end,
				color = function()
					if not package.loaded["copilot"] then
						return
					end
					local status = require("copilot.api").status.data
					return copilot_colors[status.status] or copilot_colors[""]
				end,
			},
			{
				"branch",
				icon = "",
				color = { fg = colors.green, bg = "#292A35" },
			},
			{ "diff" },
		},
		lualine_y = {
			{
				"location",
				color = { fg = colors.purple, bg = "#292A35" },
			},
		},
		lualine_z = {
			{
				color = { fg = colors.black, bg = colors.grey },
			},
		},
	},

	extensions = { "toggleterm", "mason", "neo-tree", "trouble" },
})
