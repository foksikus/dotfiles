return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			go = { "goimports", "gofmt" },
			javascript = { "prettier", stop_after_first = true },
			typescript = { "prettier", stop_after_first = true },
		},
		format_on_save = function(bufnr)
			local bufname = vim.api.nvim_buf_get_name(bufnr)
			if bufname:match("/node_modules/") then
				return
			end

			return {
				timeout_ms = 500,
				lsp_format = "fallback",
			}
		end,
	},
}
