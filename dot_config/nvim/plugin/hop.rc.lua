-----------------------------------------------------------
-- Hop setting
-----------------------------------------------------------
local status, hop = pcall(require, "hop")
if not status then
	return
end

hop.setup()
vim.keymap.set("n", "ss", hop.hint_words)
vim.keymap.set("n", "ll", hop.hint_lines)
