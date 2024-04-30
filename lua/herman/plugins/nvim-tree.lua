-- import nvim-tree plugin safely
local setup, nvimtree = pcall(require, "nvim-tree")
if not setup then
	return
end

-- recommended settings from nvim-tree documentation
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

local dracula_colors = require("dracula").colors()

-- change color for arrows in tree to light blue
vim.cmd([[ highlight NvimTreeIndentMarker guifg=]] .. dracula_colors.purple .. [[ guibg=NONE]])
vim.cmd([[ highlight NvimTreeNormal guibg=NONE]])
-- NvimTreeNormal                                                                               guifg=#f8f8f2 guibg=#21222c

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
				width = 121,
				height = 40,
				col = 29,
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
