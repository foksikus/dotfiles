local map = vim.keymap.set

map("n", "-", "<cmd>Oil --float<cr>", { desc = "Open parent directory" })
map("n", "gl", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
map("n", "<leader>ll", function()
	require("conform").format({ timeout_ms = 500 })
end, { desc = "Format current file" })

-- Move selected lines up/down
map("v", "J", ":m '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "K", ":m '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Keep the cursor centred when half-page scrolling
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Deleting doesn't overwrite the clipboard; paste over a selection keeps it
map("x", "<leader>p", '"_dP', { desc = "Paste without yanking" })
map("n", "dd", '"_dd', { silent = true })
map("v", "d", '"_d', { silent = true })
map("n", "Y", "yy", { silent = true })
