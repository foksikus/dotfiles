return {
	"ibhagwan/fzf-lua",
	dependencies = { "nvim-mini/mini.nvim" }, -- icons
	cmd = "FzfLua",
	opts = {},
	keys = {
		{ "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },
		{ "<leader>fg", "<cmd>FzfLua live_grep<cr>", desc = "Find by grep" },
		{ "<leader>fc", "<cmd>FzfLua files cwd=" .. vim.fn.stdpath("config") .. "<cr>", desc = "Find in nvim config" },
		{ "<leader>fh", "<cmd>FzfLua helptags<cr>", desc = "Find help" },
		{ "<leader>fk", "<cmd>FzfLua keymaps<cr>", desc = "Find keymaps" },
		{ "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Find current word" },
		{ "<leader>fW", "<cmd>FzfLua grep_cWORD<cr>", desc = "Find current WORD" },
		{ "<leader>fd", "<cmd>FzfLua diagnostics_document<cr>", desc = "Find diagnostics" },
		{ "<leader>fr", "<cmd>FzfLua resume<cr>", desc = "Resume last picker" },
		{ "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Find old files" },
		{ "<leader><leader>", "<cmd>FzfLua buffers<cr>", desc = "Find buffers" },
		{ "<leader>/", "<cmd>FzfLua lgrep_curbuf<cr>", desc = "Grep current buffer" },
	},
}
