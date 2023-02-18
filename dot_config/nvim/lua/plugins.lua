-----------------------------------------------------------
-- Install Vim-Jetpack
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
require("lazy").setup({
	"vim-jp/vimdoc-ja", -- vim help 日本語化
	{ "ibhagwan/fzf-lua", dependencies = { "nvim-tree/nvim-web-devicons" } },
	{ "nvim-telescope/telescope.nvim", dependencies = { "nvim-lua/plenary.nvim" } }, --fuzzy finder
	{
		"nvim-telescope/telescope-file-browser.nvim",
		dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
	}, -- telescopeでファイルを開く
	{ "nvim-telescope/telescope-frecency.nvim", dependencies = { "kkharji/sqlite.lua" } }, -- よく使うファイルを表示するtelescope拡張
	{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" }, -- telescopeの検索をfzfに
	{ "nvim-lualine/lualine.nvim", dependencies = { "nvim-tree/nvim-web-devicons", lazy = true } }, --status lineのカスタマイズ
	-- completion
	"williamboman/mason.nvim", --lsp-installerの後継
	"williamboman/mason-lspconfig.nvim", --lspconfigとの差分を吸収
	"neovim/nvim-lspconfig", --lsp設定
	"L3MON4D3/LuaSnip", --nvim-cmp用
	"saadparwaiz1/cmp_luasnip", --nvim-cmp用
	{
		"VonHeikemen/lsp-zero.nvim",
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional

			-- Autocompletion
			{ "hrsh7th/nvim-cmp" }, -- Required
			{ "hrsh7th/cmp-nvim-lsp" }, -- Required
			{ "hrsh7th/cmp-buffer" }, -- Optional
			{ "hrsh7th/cmp-path" }, -- Optional
			{ "saadparwaiz1/cmp_luasnip" }, -- Optional
			{ "hrsh7th/cmp-nvim-lua" }, -- Optional
			{ "hrsh7th/cmp-cmdline" },
			-- Snippets
			{ "L3MON4D3/LuaSnip" }, -- Required
			{ "rafamadriz/friendly-snippets" }, -- Optional
		},
	}, --lspのall-in-one設定
	"folke/lsp-colors.nvim", --lspの色をカラフルに
	"onsails/lspkind.nvim", --補完にアイコンを表示
	{
		"glepnir/lspsaga.nvim",
		event = "BufRead",
		config = function()
			require("lspsaga").setup({})
		end,
		dependencies = {
			{ "nvim-tree/nvim-web-devicons" },
			--Please make sure you install markdown and markdown_inline parser
			{ "nvim-treesitter/nvim-treesitter" },
		},
	},
	-- Linter, Formatter
	"jose-elias-alvarez/null-ls.nvim", --LinterやFormatterの設定
	"jay-babu/mason-null-ls.nvim", --Masonとnull-lsを自動連携

	-- 通知などをグラフィカルに
	{
		"folke/noice.nvim",
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},

	{ "lambdalisue/fern.vim", branch = "main", lazy = false }, --ファイラー
	"lambdalisue/fern-git-status.vim", --fernでgit差分を表示
	-- "lambdalisue/fern-renderer-nerdfont.vim", --fernでアイコンを表示
	{ "TheLeoP/fern-renderer-web-devicons.nvim", dependencies = "lambdalisue/fern.vim" }, --fernでweb-deviconを使用
	{ "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" }, --構文解析によるsyntax highlight
	"JoosepAlviste/nvim-ts-context-commentstring", --treesitterによるコメントアウト, vim-commentaryと合わせて使う
	"numToStr/Comment.nvim", --範囲コメントアウト 選択行gcc vモードgc
	"Vimjas/vim-python-pep8-indent", --pep8準拠のインデント
	"lukas-reineke/indent-blankline.nvim", --インデントを可視化
	"mhinz/vim-startify", --起動時のスタートメニューを追加
	"lambdalisue/nerdfont.vim", --Nerd font
	"hrsh7th/vim-searchx", --標準の検索をoverwrite
	{ "phaazon/hop.nvim", branch = "v2" }, --easymotionのlua版 ss
	"terryma/vim-expand-region", --visualmodeの範囲拡張 Jで縮小, Kで拡張
	"norcalli/nvim-colorizer.lua", -- 色コードをその色に変換
	"lambdalisue/suda.vim", -- sudo権限でのread/writeを追加(SudaRead/SudaWrite)
	-- colorschemes
	{ "dracula/vim", name = "dracula" },
	{ "sainnhe/gruvbox-material", name = "gruvbox-material" },
	{ "cocopon/iceberg.vim", name = "iceberg" },
	{ "Mofiqul/vscode.nvim", name = "codedark" },
	{ "EdenEast/nightfox.nvim", name = "nightfox" },
	{ "folke/tokyonight.nvim", name = "tokyonight" },
	{ "sainnhe/everforest", name = "everforest" },
})
