-- LSP on Neovim 0.12: servers are configured with vim.lsp.config() and started
-- with vim.lsp.enable(). nvim-lspconfig only supplies the default server configs,
-- Mason installs the binaries. blink.cmp registers its capabilities on its own.

-- Servers to install and enable. Add per-server overrides as the value.
local servers = {
	clangd = {},
	gopls = {},
	ts_ls = {},
	lua_ls = {
		settings = {
			Lua = {
				runtime = { version = "LuaJIT" },
				workspace = { checkThirdParty = false, library = { vim.env.VIMRUNTIME } },
			},
		},
	},
}

-- Formatters used by conform.nvim
local tools = { "stylua", "prettierd", "goimports" }

return {
	"neovim/nvim-lspconfig",
	dependencies = {
		{ "mason-org/mason.nvim", opts = {} },
		-- Only used to translate lspconfig names to Mason package names
		{ "mason-org/mason-lspconfig.nvim", opts = { automatic_enable = false } },
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		{ "j-hui/fidget.nvim", opts = {} },
	},
	config = function()
		require("mason-tool-installer").setup({
			ensure_installed = vim.list_extend(vim.tbl_keys(servers), tools),
		})

		for name, cfg in pairs(servers) do
			if next(cfg) then
				vim.lsp.config(name, cfg)
			end
		end
		vim.lsp.enable(vim.tbl_keys(servers))

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
			callback = function(event)
				local fzf = require("fzf-lua")
				local map = function(keys, func, desc, mode)
					vim.keymap.set(mode or "n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
				end

				-- Neovim already provides: K hover, grn rename, gra code action,
				-- gO document symbols, <C-s> signature help, [d / ]d diagnostics.
				-- The ones below swap in fzf-lua pickers.
				map("gd", fzf.lsp_definitions, "Goto definition")
				map("gD", vim.lsp.buf.declaration, "Goto declaration")
				map("grr", fzf.lsp_references, "Goto references")
				map("gri", fzf.lsp_implementations, "Goto implementation")
				map("grt", fzf.lsp_typedefs, "Goto type definition")
				map("gO", fzf.lsp_document_symbols, "Document symbols")
				map("<leader>ws", fzf.lsp_live_workspace_symbols, "Workspace symbols")
				-- Kept for muscle memory
				map("<leader>rn", vim.lsp.buf.rename, "Rename")
				map("<leader>ca", vim.lsp.buf.code_action, "Code action", { "n", "x" })

				local client = vim.lsp.get_client_by_id(event.data.client_id)
				if not client then
					return
				end

				-- Highlight references of the word under the cursor
				if client:supports_method("textDocument/documentHighlight", event.buf) then
					local group = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
					vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
						buffer = event.buf,
						group = group,
						callback = vim.lsp.buf.document_highlight,
					})
					vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
						buffer = event.buf,
						group = group,
						callback = vim.lsp.buf.clear_references,
					})
					vim.api.nvim_create_autocmd("LspDetach", {
						buffer = event.buf,
						group = group,
						callback = function(ev)
							vim.lsp.buf.clear_references()
							vim.api.nvim_clear_autocmds({ group = group, buffer = ev.buf })
						end,
					})
				end

				if client:supports_method("textDocument/inlayHint", event.buf) then
					map("<leader>th", function()
						vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
					end, "Toggle inlay hints")
				end
			end,
		})

		vim.diagnostic.config({
			severity_sort = true,
			float = { border = "rounded", source = "if_many" },
			underline = { severity = vim.diagnostic.severity.ERROR },
			virtual_text = { source = "if_many", spacing = 2 },
			signs = {
				text = {
					[vim.diagnostic.severity.ERROR] = "󰅚 ",
					[vim.diagnostic.severity.WARN] = "󰀪 ",
					[vim.diagnostic.severity.INFO] = "󰋽 ",
					[vim.diagnostic.severity.HINT] = "󰌶 ",
				},
			},
		})
	end,
}
