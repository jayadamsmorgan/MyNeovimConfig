-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local dracula_colors = require("dracula").colors()

vim.cmd([[ highlight NvimTreeIndentMarker guifg=]] .. dracula_colors.purple .. [[ guibg=NONE]])
vim.cmd([[ highlight NvimTreeNormal guibg=NONE]])

-- configure nvim-tree
nvimtree.setup({
	filters = {
		dotfiles = true,
	},
	view = {
		--width = 20,
		float = {
			enable = true,
			open_win_config = {
				relative = "editor",
				border = "rounded",
				title = "NvimTree",
				title_pos = "center",
				width = 120,
				height = 40,
				col = vim.api.nvim_win_get_width(0) / 2 - 61,
				row = vim.api.nvim_win_get_height(0) / 2 - 25,
			},
		},
	},
	renderer = {
		icons = {
			glyphs = {
				folder = {
					arrow_closed = "", -- arrow when folder is closed
					arrow_open = "", -- arrow when folder is open
				},
				git = {
					unstaged = "",
					staged = "✓",
					unmerged = "",
					renamed = "➜",
					untracked = "󰓏",
					deleted = "",
					ignored = "◌",
				},
			},
		},
	},
	-- disable window_picker for
	-- explorer to work well with
	-- window splits
	actions = {
		open_file = {
			window_picker = {
				enable = false,
			},
		},
	},
})
