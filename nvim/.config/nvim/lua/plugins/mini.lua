-- All mini modules come from the single mini.nvim repo.
return {
	"nvim-mini/mini.nvim",
	version = false,
	lazy = false,
	config = function()
		require("mini.icons").setup()
		require("mini.statusline").setup()
		require("mini.jump").setup()

		-- Surround on gs… (s belongs to flash): gsa{motion}{char} add,
		-- gsd{char} delete, gsr{old}{new} replace, e.g. gsaiw" or gsr'"
		require("mini.surround").setup({
			mappings = {
				add = "gsa",
				delete = "gsd",
				find = "gsf",
				find_left = "gsF",
				highlight = "gsh",
				replace = "gsr",
			},
		})

		-- Highlight TODO/FIXME/HACK/NOTE and show #rrggbb colours inline
		local hipatterns = require("mini.hipatterns")
		hipatterns.setup({
			highlighters = {
				fixme = { pattern = "%f[%w]()FIXME()%f[%W]", group = "MiniHipatternsFixme" },
				hack = { pattern = "%f[%w]()HACK()%f[%W]", group = "MiniHipatternsHack" },
				todo = { pattern = "%f[%w]()TODO()%f[%W]", group = "MiniHipatternsTodo" },
				note = { pattern = "%f[%w]()NOTE()%f[%W]", group = "MiniHipatternsNote" },
				hex_color = hipatterns.gen_highlighter.hex_color(),
			},
		})

		-- Popup listing the next possible keys after <leader>, g, [, ], z, <C-w>, ...
		local clue = require("mini.clue")
		clue.setup({
			triggers = {
				{ mode = { "n", "x" }, keys = "<Leader>" },
				{ mode = "n", keys = "[" },
				{ mode = "n", keys = "]" },
				{ mode = "i", keys = "<C-x>" },
				{ mode = { "n", "x" }, keys = "g" },
				{ mode = { "n", "x" }, keys = "'" },
				{ mode = { "n", "x" }, keys = "`" },
				{ mode = { "n", "x" }, keys = '"' },
				{ mode = { "i", "c" }, keys = "<C-r>" },
				{ mode = "n", keys = "<C-w>" },
				{ mode = { "n", "x" }, keys = "z" },
			},
			clues = {
				{ mode = "n", keys = "<Leader>a", desc = "+AI (Claude)" },
				{ mode = "n", keys = "<Leader>c", desc = "+Code" },
				{ mode = "n", keys = "<Leader>f", desc = "+Find" },
				{ mode = "n", keys = "<Leader>h", desc = "+Git hunks" },
				{ mode = "n", keys = "<Leader>l", desc = "+Format" },
				{ mode = "n", keys = "<Leader>m", desc = "+Multicursor" },
				{ mode = "n", keys = "<Leader>t", desc = "+Toggle" },
				{ mode = "n", keys = "<Leader>w", desc = "+Workspace" },
				{ mode = "n", keys = "gs", desc = "+Surround" },
				clue.gen_clues.square_brackets(),
				clue.gen_clues.builtin_completion(),
				clue.gen_clues.g(),
				clue.gen_clues.marks(),
				clue.gen_clues.registers(),
				clue.gen_clues.windows(),
				clue.gen_clues.z(),
			},
			window = { delay = 300 },
		})

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
