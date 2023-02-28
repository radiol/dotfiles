return {
	{
		"terryma/vim-expand-region",
		config = function()
			vim.keymap.set("v", "<C-k>", "<Plug>(expand_region_expand)")
			vim.keymap.set("v", "<C-j>", "<Plug>(expand_region_shrink)")
		end,
	},
}
