-- All mini modules come from the single mini.nvim repo.
return {
	"nvim-mini/mini.nvim",
	version = false,
	lazy = false,
	config = function()
		require("mini.icons").setup()
		require("mini.statusline").setup()
		require("mini.jump").setup()

		-- a/i text objects. `af`/`if` and `aa`/`ia` use tree-sitter queries
		-- (from nvim-treesitter-textobjects); everything else is mini.ai's
		-- built-ins (brackets, quotes, `q`, `b`, `t` tags, ...).
		local ai = require("mini.ai")
		ai.setup({
			n_lines = 500,
			custom_textobjects = {
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }),
				a = ai.gen_spec.treesitter({ a = "@parameter.outer", i = "@parameter.inner" }),
			},
		})

		-- Auto pairs: only insert a closing pair before whitespace or a closing
		-- bracket, and never pair quotes next to a letter.
		--   foo|bar  + "(" -> foo(bar      foobar| + "(" -> foobar()
		local open_before = ".[%s%z%)}%]]"
		local no_letter = "[^%w\\][^%w]"
		require("mini.pairs").setup({
			modes = { insert = true, command = false, terminal = false },
			mappings = {
				["("] = { action = "open", pair = "()", neigh_pattern = ".[%s%z%)]", register = { cr = false } },
				["["] = { action = "open", pair = "[]", neigh_pattern = open_before, register = { cr = false } },
				["{"] = { action = "open", pair = "{}", neigh_pattern = open_before, register = { cr = false } },
				[")"] = { action = "close", pair = "()", neigh_pattern = "[^\\]." },
				["]"] = { action = "close", pair = "[]", neigh_pattern = "[^\\]." },
				["}"] = { action = "close", pair = "{}", neigh_pattern = "[^\\]." },
				['"'] = { action = "closeopen", pair = '""', neigh_pattern = no_letter, register = { cr = false } },
				["'"] = { action = "closeopen", pair = "''", neigh_pattern = no_letter, register = { cr = false } },
				["`"] = { action = "closeopen", pair = "``", neigh_pattern = no_letter, register = { cr = false } },
			},
		})
	end,
}
