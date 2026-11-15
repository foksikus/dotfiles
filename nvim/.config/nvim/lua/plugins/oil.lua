return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-mini/mini.nvim" }, -- icons
	lazy = false, -- oil should not be lazy-loaded
	---@module 'oil'
	---@type oil.SetupOpts
	opts = {
		columns = { "icon", "size" },
		view_options = { show_hidden = true },
		skip_confirm_for_simple_edits = true,
		prompt_save_on_select_new_entry = false,
	},
}
