-- nvim-treesitter `main` branch (the rewrite for Neovim 0.12). It only installs
-- parsers and queries; highlighting/indent are switched on per buffer below.
-- Requires the `tree-sitter` CLI and a C compiler (see Brewfile).
local parsers = {
	"c",
	"css",
	"go",
	"html",
	"javascript",
	"json",
	"lua",
	"markdown",
	"scss",
	"typescript",
	"vim",
	"vimdoc",
}

return {
	{
		"nvim-treesitter/nvim-treesitter",
		branch = "main",
		lazy = false,
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter").install(parsers)

			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("user-treesitter", { clear = true }),
				callback = function(args)
					-- Fails quietly for filetypes without a parser
					if pcall(vim.treesitter.start, args.buf) then
						vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
					end
				end,
			})
		end,
	},
	{
		-- Provides the @function/@parameter queries used by mini.ai (see mini.lua)
		-- and the function jumps below.
		"nvim-treesitter/nvim-treesitter-textobjects",
		branch = "main",
		lazy = false,
		config = function()
			require("nvim-treesitter-textobjects").setup({ move = { set_jumps = true } })

			local move = require("nvim-treesitter-textobjects.move")
			local jumps = {
				["]f"] = { move.goto_next_start, "Next function start" },
				["[f"] = { move.goto_previous_start, "Previous function start" },
				["]F"] = { move.goto_next_end, "Next function end" },
				["[F"] = { move.goto_previous_end, "Previous function end" },
			}
			for lhs, m in pairs(jumps) do
				vim.keymap.set({ "n", "x", "o" }, lhs, function()
					m[1]("@function.outer", "textobjects")
				end, { desc = m[2] })
			end
		end,
	},
}
