-- Prefer the prettierd daemon, fall back to the project's prettier
local web = { "prettierd", "prettier", stop_after_first = true }

return {
	"stevearc/conform.nvim",
	opts = {
		formatters_by_ft = {
			lua = { "stylua" },
			c = { "clang-format" },
			cpp = { "clang-format" },
			go = { "goimports", "gofumpt" }, -- imports first, then stricter gofmt
			javascript = web,
			javascriptreact = web,
			typescript = web,
			typescriptreact = web,
			svelte = web, -- needs prettier-plugin-svelte in the project
			html = web,
			css = web,
			scss = web,
			json = web,
			jsonc = web,
			yaml = web,
			markdown = web,
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
