return {
	"nvim-treesitter/nvim-treesitter",
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
			ensure_installed = { "json", "c", "lua", "vim", "vimdoc", "javascript", "html", "typescript", "css", "scss" },
			sync_install = true,
			highlight = { enable = true },
			indent = { enable = true },
		})
	end,
}
