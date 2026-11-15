-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		"https://github.com/folke/lazy.nvim.git",
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Leader must be set before lazy.nvim loads so plugin mappings use it
vim.g.mapleader = " "
vim.g.maplocalleader = " "
require("config.options")

require("lazy").setup({
	spec = { { import = "plugins" } },
	install = { colorscheme = { "lackluster-mint", "habamax" } },
	-- Check for updates in the background; see them with :Lazy
	checker = { enabled = true, notify = false },
})

require("config.keymaps")
