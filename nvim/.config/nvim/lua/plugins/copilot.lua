-- Copilot only feeds the blink.cmp menu (via blink-copilot); ghost text and the
-- panel are switched off. Run :Copilot auth once if you aren't signed in.
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		suggestion = { enabled = false },
		panel = { enabled = false },
	},
}
