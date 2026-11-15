return {
	"slugbyte/lackluster.nvim",
	lazy = false,
	priority = 1000,
	config = function()
		-- variants: "lackluster", "lackluster-hack", "lackluster-mint"
		vim.cmd.colorscheme("lackluster-mint")
	end,
}
