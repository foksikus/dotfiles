-- go.nvim for its Go commands (:GoTest, :GoFillStruct, :GoIfErr, ...).
-- gopls is set up in lsp.lua and goimports runs on save via conform.nvim,
-- so go.nvim's own LSP, formatting and text objects stay off.
return {
	"ray-x/go.nvim",
	dependencies = { "ray-x/guihua.lua", "neovim/nvim-lspconfig", "nvim-treesitter/nvim-treesitter" },
	ft = { "go", "gomod" },
	build = ':lua require("go.install").update_all_sync()',
	opts = {
		lsp_cfg = false,
		lsp_keymaps = false,
		diagnostic = false,
		textobjects = false, -- mini.ai provides af/if
		dap_debug = false, -- nvim-dap isn't installed
	},
}
