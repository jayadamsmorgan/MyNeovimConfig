local status, _ = pcall(vim.cmd, "colorscheme dracula")
if not status then
	print("Cannot load colorscheme!") -- print error if colorscheme not installed
	return
end
