-- Based on kickstart.nvim. Options that are already Neovim defaults
-- (autoindent, smarttab, ...) are left out.
local o = vim.opt

o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.scrolloff = 15
o.showmode = false -- mini.statusline shows the mode
o.breakindent = true
o.splitright = true
o.splitbelow = true

-- Indentation fallback; vim-sleuth adjusts per file.
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4
o.softtabstop = 4

o.undofile = true
o.ignorecase = true
o.smartcase = true

o.list = true
o.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Sync with the OS clipboard (deferred, it can slow down startup)
vim.schedule(function()
	o.clipboard = "unnamedplus"
end)

vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking text",
	group = vim.api.nvim_create_augroup("user-highlight-yank", { clear = true }),
	callback = function()
		vim.hl.on_yank()
	end,
})
