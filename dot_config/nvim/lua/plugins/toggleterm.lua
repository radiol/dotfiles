return {
	{
		"akinsho/toggleterm.nvim",
		version = "*",
		config = function()
			local toggleterm = require("toggleterm")
			local Terminal = require("toggleterm.terminal").Terminal

			-- Open float window(Ctrl-t)
			toggleterm.setup({
				open_mapping = [[<c-t>]],
				direction = "float",
				float_opts = { border = "double" },
			})

			-- Open lazygit(keymap=lg)
			local lazygit = Terminal:new({ cmd = "lazygit", hidden = true })
			function _lazygit_toggle()
				lazygit:toggle()
			end
			vim.api.nvim_set_keymap("n", "lg", "<cmd>lua _lazygit_toggle()<CR>", { noremap = true, silent = true })
		end,
	},
}
