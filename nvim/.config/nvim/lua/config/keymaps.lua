vim.keymap.set("n", "-", "<CMD>Oil --float<CR>", { desc = "Open parent directory" })
vim.keymap.set("n", "gl", function()
	vim.diagnostic.open_float()
end, { desc = "Open diagnostic float" })

-- move lines up or down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

vim.keymap.set("x", "<leader>p", '"_dP')

vim.keymap.set("n", "<leader>cf", function()
	require("conform").format({
		timeout_ms = 500,
		lsp_format = "fallback",
	})
end, { desc = "Format current file" })

vim.keymap.set("", "<leader>=", function()
	require("conform").format({ async = true }, function(err)
		if not err then
			local mode = vim.api.nvim_get_mode().mode
			if vim.startswith(string.lower(mode), "v") then
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
			end
		end
	end)
end, { desc = "Format code" })

vim.keymap.set("n", "dd", '"_dd', { noremap = true, silent = true })
-- In visual mode, pressing d deletes the selected whole lines
vim.keymap.set("v", "d", '"_d', { noremap = true, silent = true })
-- Remap <Enter> in normal mode to 'o' followed by '<Esc>'
vim.keymap.set("n", "<CR>", "o<Esc>", { noremap = true, silent = true })
-- Remap <C-Enter> in normal mode to 'O' followed by '<Esc>'
vim.keymap.set("n", "<C-CR>", "O<Esc>", { noremap = true, silent = true })
