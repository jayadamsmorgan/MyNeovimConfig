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

local screen_width = vim.api.nvim_win_get_width(0)
local screen_height = vim.api.nvim_win_get_height(0)

local tree_width = math.floor(screen_width * 0.6)
local tree_height = math.floor(screen_height * 0.9)

-- expand all folders when opening nvim-tree

local function on_attach(bufnr)
	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	local api = require("nvim-tree.api")
	api.config.mappings.default_on_attach(bufnr)

	vim.keymap.set("n", "<ESC>", api.tree.close, opts("Close"))
end

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
				title = "File Browser",
				title_pos = "center",
				width = tree_width,
				height = tree_height,
				col = (screen_width - tree_width) / 2,
				row = (screen_height - tree_height) / 2,
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
	on_attach = on_attach,
})
