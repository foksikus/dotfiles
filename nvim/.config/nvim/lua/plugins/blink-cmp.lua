return {
	"saghen/blink.cmp",
	version = "1.*", -- release tags ship pre-built binaries
	dependencies = {
		"rafamadriz/friendly-snippets",
		"fang2hou/blink-copilot",
	},
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = { preset = "super-tab" },
		appearance = { nerd_font_variant = "mono" },
		completion = { documentation = { auto_show = false } },
		signature = { enabled = true },
		sources = {
			default = { "copilot", "lsp", "path", "snippets" },
			providers = {
				copilot = { name = "copilot", module = "blink-copilot", score_offset = 100, async = true },
			},
		},
		fuzzy = { implementation = "prefer_rust_with_warning" },
	},
	opts_extend = { "sources.default" },
}
