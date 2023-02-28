return {
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			local hop = require("hop")
			hop.setup()
			vim.keymap.set("n", "ss", hop.hint_words)
			vim.keymap.set("n", "ll", hop.hint_lines)
		end,
	},
}
