-- One set of keys for Neovim splits and tmux panes:
--   <C-h/j/k/l> move, <M-h/j/k/l> resize (Option = Alt in Alacritty).
-- The tmux half lives in tmux.conf (smart-splits-nvim/backend-tmux via TPM).
return {
	"smart-splits-nvim/smart-splits.nvim",
	lazy = false, -- must load at startup so tmux knows this pane runs Neovim
	dependencies = {
		{ "smart-splits-nvim/backend-tmux", main = "smart-splits-backend-tmux", opts = {} },
	},
	opts = {
		mux = { backend = "smart-splits-backend-tmux" },
	},
	config = function(_, opts)
		local ss = require("smart-splits")
		ss.setup(opts)
		local map = vim.keymap.set
		map("n", "<C-h>", ss.move_cursor_left, { desc = "Move to left split/pane" })
		map("n", "<C-j>", ss.move_cursor_down, { desc = "Move to lower split/pane" })
		map("n", "<C-k>", ss.move_cursor_up, { desc = "Move to upper split/pane" })
		map("n", "<C-l>", ss.move_cursor_right, { desc = "Move to right split/pane" })
		map("n", "<M-h>", ss.resize_left, { desc = "Resize left" })
		map("n", "<M-j>", ss.resize_down, { desc = "Resize down" })
		map("n", "<M-k>", ss.resize_up, { desc = "Resize up" })
		map("n", "<M-l>", ss.resize_right, { desc = "Resize right" })
	end,
}
