-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

---------------------
-- General Keymaps
---------------------

keymap.set("n", "<leader>wq", ":wqa<CR>")

keymap.set("n", "<leader>ff", ":%s/")

keymap.set("v", "J", ":m '>+1<CR>gv=gv")
keymap.set("v", "K", ":m '<-2<CR>gv=gv")

keymap.set("n", ">", '"_>>')
keymap.set("n", "<", '"_<<')

keymap.set("v", ">", '"_>gv')
keymap.set("v", "<", '"_<gv')

keymap.set("v", "p", '"_dP')

keymap.set("n", "<leader>d", '"_d')
keymap.set("v", "<leader>d", '"_d')

keymap.set("n", "<leader>,", "<C-w>h")
keymap.set("n", "<leader>.", "<C-w>l")

-- Undo tree
keymap.set("n", "<leader>ut", vim.cmd.UndotreeToggle)

-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- window management
keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

-- keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
-- keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
-- keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
-- keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab
-- keymap.set("n", "<leader>tX", ":tabonly<CR>") --  close other tabs

-- toggle wrap
keymap.set("n", "<leader>we", ":set wrap!<CR>")

-- PlatformIO
keymap.set("n", "<leader>pr", ":wa<CR>:!pio run<CR>")
keymap.set("n", "<leader>pu", ":wa<CR>:!pio run -t upload<CR>")
keymap.set("n", "<leader>pe", ":wa<CR>:!pio run -e ")
keymap.set("n", "<leader>pd", ":wa<CR>:!pio run -t compiledb<CR>:LspRestart<CR>")
keymap.set("n", "<leader>pc", ":!pio run -t clean<CR>")

-- CMake
keymap.set("n", "<leader>cm", ":wa<CR>:!cmake . && make<CR>")
keymap.set("n", "<leader>cr", ":wa<CR>:!cmake . && make && ./build/ssf")

-- Makefile
keymap.set("n", "<leader>mcb", ":wa<CR>:! make -j9 all<CR>")
keymap.set("n", "<leader>mcr", ":wa<CR>:! make -j9 all<CR>:! ./build/main<CR>")
keymap.set("n", "<leader>mcc", "!make clean")

-- STM32 Makefile
keymap.set("n", "<leader>msb", ":wa<CR>:! (cd Makefile && make -j9 all)<CR>")
keymap.set(
	"n",
	"<leader>msc",
	":! (cd Makefile && make -j9 clean && cd CM4 && make -j9 clean && cd ../CM7 && make -j9 clean)<CR>"
)
keymap.set(
	"n",
	"<leader>msd",
	":wa<CR>:! (cd Makefile && compiledb -o ../compile_commands.json make -j9 all)<CR>:LspRestart<CR>"
)

-- Swift
keymap.set("n", "<leader>sb", ":wa<CR>:!swift build<CR>")
keymap.set("n", "<leader>sr", ":wa<CR>:!swift run<CR>")
keymap.set("n", "<leader>st", ":wa<CR>:!swift test | xcbeautify<CR>")

----------------------
-- Plugin Keybinds
----------------------
-- Harpoon
keymap.set("n", "<leader>hh", ":lua require('harpoon.mark').add_file()<CR>")
keymap.set("n", "<leader>hm", ":lua require('harpoon.ui').toggle_quick_menu()<CR>")
for i = 1, 9 do
	keymap.set("n", "<M-" .. tostring(i) .. ">", ":lua require('harpoon.ui').nav_file(" .. tostring(i) .. ")<CR>")
end
keymap.set("n", "<M-" .. ".>", ":lua require('harpoon.ui').nav_next()<CR>")
keymap.set("n", "<M-" .. ",>", ":lua require('harpoon.ui').nav_prev()<CR>")

-- vim-maximizer
keymap.set("n", "<leader>sm", ":MaximizerToggle<CR>") -- toggle split window maximization

-- nvim-tree
keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>") -- toggle file explorer

-- telescope
keymap.set("n", "<leader>tf", "<cmd>Telescope find_files<cr>") -- find files within current working directory, respects .gitignore
keymap.set("n", "<leader>tb", "<cmd>Telescope buffers<cr>") -- list open buffers in current neovim instance
keymap.set("n", "<leader>tw", "<cmd>Telescope live_grep<cr>") -- search for word in current working directory
keymap.set("n", "<leader>tr", "<cmd>Telescope oldfiles<cr>") -- list recently opened files
keymap.set("n", "<leader>tg", "<cmd>Telescope git_files<cr>") -- list git files
keymap.set("n", "<leader>th", "<cmd>Telescope help_tags<cr>") -- search for help tags
keymap.set("n", "<leader>ts", "<cmd>Telescope lsp_document_symbols<cr>") -- search for symbols in current buffer
keymap.set("n", "<leader>ti", "<cmd>Telescope lsp_implementations<cr>") -- search for implementations in current buffer
keymap.set("n", "<leader>tt", "<cmd>Telescope lsp_type_definitions<cr>") -- search for type definitions in current buffer
keymap.set("n", "<leader>tr", "<cmd>Telescope lsp_references<cr>") -- search for references in current buffer
keymap.set("n", "<leader>te", "<cmd>Telescope lsp_workspace_symbols<cr>") -- search for symbols in current workspace

-- startup-nvim
keymap.set("n", "<leader>nf", ":lua require'startup'.new_file()<CR>") -- create new file

-- MarkdownPreview
keymap.set("n", "<leader>md", ":MarkdownPreviewToggle<CR>")
