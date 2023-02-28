return {
	{ "vim-jp/vimdoc-ja" },
	{ "norcalli/nvim-colorizer.lua", name = "colorizer", opts = { "*" } },
	{ "windwp/nvim-autopairs", opts = {} },
	{ "Vimjas/vim-python-pep8-indent" }, --pep8準拠のインデント
	{ "lukas-reineke/indent-blankline.nvim" }, --インデントを可視化
	{ "mhinz/vim-startify" }, --起動時のスタートメニューを追加
	{ "lambdalisue/nerdfont.vim" }, --Nerd font
	{ "lambdalisue/suda.vim" }, -- sudo権限でのread/writeを追加(SudaRead/SudaWrite)
	{ "jghauser/mkdir.nvim" }, -- 保存時にディレクトリが無い場合には自動で作成
}
