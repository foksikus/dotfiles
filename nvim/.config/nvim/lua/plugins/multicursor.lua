-- Multiple cursors. Add cursors, then edit normally (i, c, d, ., ...);
-- every cursor does the same. <Esc> clears them.
--   <Up>/<Down>         add a cursor on the line above/below
--   <leader>mn / mN     add a cursor on the next/previous match of the word/selection
--   <leader>ms / mS     skip the next/previous match
--   <leader>mA          add cursors on every match in the file
--   ga{motion}          add a cursor on each line, e.g. gaip = every line of the paragraph
--   <C-LeftMouse>       add/remove a cursor with the mouse
--   while active: <Left>/<Right> switch the main cursor, <leader>mx deletes it
return {
	"jake-stewart/multicursor.nvim",
	branch = "1.0",
	event = "VeryLazy",
	config = function()
		local mc = require("multicursor-nvim")
		mc.setup()

		local set = vim.keymap.set
		set({ "n", "x" }, "<Up>", function() mc.lineAddCursor(-1) end, { desc = "Add cursor above" })
		set({ "n", "x" }, "<Down>", function() mc.lineAddCursor(1) end, { desc = "Add cursor below" })
		set({ "n", "x" }, "<leader>mn", function() mc.matchAddCursor(1) end, { desc = "Add cursor at next match" })
		set({ "n", "x" }, "<leader>mN", function() mc.matchAddCursor(-1) end, { desc = "Add cursor at prev match" })
		set({ "n", "x" }, "<leader>ms", function() mc.matchSkipCursor(1) end, { desc = "Skip next match" })
		set({ "n", "x" }, "<leader>mS", function() mc.matchSkipCursor(-1) end, { desc = "Skip prev match" })
		set({ "n", "x" }, "<leader>mA", mc.matchAllAddCursors, { desc = "Add cursors at all matches" })
		set({ "n", "x" }, "<leader>mr", mc.restoreCursors, { desc = "Restore cleared cursors" })
		set({ "n", "x" }, "ga", mc.addCursorOperator, { desc = "Add cursor per line (operator)" })
		set("n", "<c-leftmouse>", mc.handleMouse)
		set("n", "<c-leftdrag>", mc.handleMouseDrag)
		set("n", "<c-leftrelease>", mc.handleMouseRelease)

		-- Only active while there are multiple cursors
		mc.addKeymapLayer(function(layer)
			layer({ "n", "x" }, "<Left>", mc.prevCursor)
			layer({ "n", "x" }, "<Right>", mc.nextCursor)
			layer({ "n", "x" }, "<leader>mx", mc.deleteCursor)
			layer("n", "<Esc>", function()
				if not mc.cursorsEnabled() then
					mc.enableCursors()
				else
					mc.clearCursors()
				end
			end)
		end)

		local hl = vim.api.nvim_set_hl
		hl(0, "MultiCursorCursor", { reverse = true })
		hl(0, "MultiCursorVisual", { link = "Visual" })
		hl(0, "MultiCursorSign", { link = "SignColumn" })
		hl(0, "MultiCursorMatchPreview", { link = "Search" })
		hl(0, "MultiCursorDisabledCursor", { reverse = true })
		hl(0, "MultiCursorDisabledVisual", { link = "Visual" })
		hl(0, "MultiCursorDisabledSign", { link = "SignColumn" })
	end,
}
