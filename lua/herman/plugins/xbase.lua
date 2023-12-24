-- import cmp-nvim-lsp plugin safely
local cmp_nvim_lsp_status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not cmp_nvim_lsp_status then
	return
end

local keymap = vim.keymap -- for conciseness

-- enable keybinds only for when lsp server available
local on_attach = function(client, bufnr)
	-- keybind options
	local opts = { noremap = true, silent = true, buffer = bufnr }

	-- set keybinds
	keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts) -- show definition, references
	keymap.set("n", "gD", "<Cmd>lua vim.lsp.buf.declaration()<CR>", opts) -- got to declaration
	keymap.set("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts) -- see definition and make edits in window
	keymap.set("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts) -- go to implementation
	keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts) -- see available code actions
	keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts) -- smart rename
	keymap.set("n", "<leader>D", "<cmd>Lspsaga show_line_diagnostics<CR>", opts) -- show  diagnostics for line
	keymap.set("n", "<leader>d", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts) -- show diagnostics for cursor
	keymap.set("n", "[d", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts) -- jump to previous diagnostic in buffer
	keymap.set("n", "]d", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts) -- jump to next diagnostic in buffer
	keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts) -- show documentation for what is under cursor
	keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts) -- see outline on right hand side

	-- typescript specific keymaps (e.g. rename file and update imports)
	if client.name == "tsserver" then
		keymap.set("n", "<leader>rf", ":TypescriptRenameFile<CR>") -- rename file and update imports
		keymap.set("n", "<leader>oi", ":TypescriptOrganizeImports<CR>") -- organize imports (not in youtube nvim video)
		keymap.set("n", "<leader>ru", ":TypescriptRemoveUnused<CR>") -- remove unused variables (not in youtube nvim video)
	end
end

-- used to enable autocompletion (assign to every lsp server config)
local capabilities = cmp_nvim_lsp.default_capabilities()

require("xbase").setup( -- NOTE: Defaults
	{
		--- Log level. Set it to ERROR to ignore everything
		log_level = vim.log.levels.DEBUG,
		sourcekit = {
			filetypes = { "swift", "objc", "objcpp", "cuda", "proto" },
			cmd = {
				"/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/sourcekit-lsp",
			},
			root_dir = require("lspconfig").util.root_pattern(".git", "Package.swift", "project.yml", "Project.swift"),
			on_attach = on_attach,
			capabilities = capabilities,
		},
		--- Statusline provider configurations
		statusline = {
			watching = { icon = "󰮔", color = "#1abc9c" },
			device_running = { icon = "󱀟", color = "#4a6edb" },
			success = { icon = "", color = "#1abc9c" },
			failure = { icon = "", color = "#db4b4b" },
		},
		--- Simulators to only include.
		--- run `xcrun simctl list` to get a full list of available simulator
		--- If the list is empty then all simulator available  will be included
		simctl = {
			iOS = {},
			watchOS = {}, -- all available devices
			tvOS = {}, -- all available devices
		},
		--- Log buffer configurations
		log_buffer = {
			--- Whether toggling the buffer should auto focus to it?
			focus = true,
			--- Split Log buffer height
			height = 20,
			--- Vsplit Log buffer width
			width = 75,
			--- Default log buffer direction: { "horizontal", "vertical" }
			default_direction = "horizontal",
		},
		--- Mappings
		mappings = {
			--- Whether xbase mapping should be disabled.
			enable = true,
			--- Open build picker. showing targets and configuration.
			build_picker = "<leader>xb", --- set to 0 to disable
			--- Open run picker. showing targets, devices and configuration
			run_picker = "<leader>xr", --- set to 0 to disable
			--- Open watch picker. showing run or build, targets, devices and configuration
			watch_picker = "<leader>xs", --- set to 0 to disable
			--- A list of all the previous pickers
			all_picker = "<leader>xef", --- set to 0 to disable
			--- horizontal toggle log buffer
			toggle_split_log_buffer = "<leader>xlh",
			--- vertical toggle log buffer
			toggle_vsplit_log_buffer = "<leader>xlv",
		},
	}
)
