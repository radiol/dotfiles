return {
	{
		"lambdalisue/fern.vim",
		branch = "main",
		dependencies = {
			{ "lambdalisue/fern-git-status.vim" },
			{ "TheLeoP/fern-renderer-web-devicons.nvim", dependencies = "lambdalisue/fern.vim" },
		},
		config = function()
			vim.g["fern#renderer"] = "nvim-web-devicons"
			vim.keymap.set("n", "<C-f>", "<cmd>Fern %:h -reveal=% -drawer -toggle<CR>")
		end,
	},
}
