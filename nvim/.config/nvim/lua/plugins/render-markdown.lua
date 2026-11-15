-- Rendered headings, lists, tables and code blocks inside markdown buffers.
-- Toggle with :RenderMarkdown toggle
return {
	"MeanderingProgrammer/render-markdown.nvim",
	dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-mini/mini.nvim" },
	ft = { "markdown" },
	---@module 'render-markdown'
	---@type render.md.UserConfig
	opts = {
		completions = { lsp = { enabled = true } }, -- checkbox/callout completions
		latex = { enabled = false },
	},
}
