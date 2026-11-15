return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports" }, -- goimports also runs gofmt
			javascript = { "prettierd", "prettier", stop_after_first = true },
			typescript = { "prettierd", "prettier", stop_after_first = true },
		},
		default_format_opts = { lsp_format = "fallback" },
		format_on_save = function(bufnr)
			if vim.api.nvim_buf_get_name(bufnr):match("/node_modules/") then
				return
			end
			return { timeout_ms = 500 }
		end,
	},
}
