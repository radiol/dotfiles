-----------------------------------------------------------
-- Install Vim-Jetpack
-----------------------------------------------------------
local jetpack_url = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
local jetpack_root = vim.fn.expand("<sfile>:p:h") .. "/pack/jetpack/opt/vim-jetpack/plugin/"
local jetpack_vim = jetpack_root .. "/jetpack.vim"
local do_sync = false
if vim.fn.filereadable(jetpack_vim) == 0 then
	vim.fn.execute("!curl -fLo " .. jetpack_vim .. " --create-dirs " .. jetpack_url)
	do_sync = true
end
vim.fn.execute("source " .. jetpack_vim)

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
local status, jetpack = pcall(require, "jetpack.packer")
if not status then
	print("vim-jetpack is not installed")
	return
end

jetpack.startup(function(use)
	use({ "tani/vim-jetpack", opt = 1 })
	use("vim-jp/vimdoc-ja") -- vim help 日本語化
	use("junegunn/fzf.vim")
	use({ "junegunn/fzf", run = "call fzf#install()" })
	use("nvim-lua/plenary.nvim") --telescope, null-lsに必要
	use("nvim-telescope/telescope.nvim") --fuzzy finder
	use("nvim-telescope/telescope-file-browser.nvim") -- telescopeでファイルを開く
	use("nvim-lualine/lualine.nvim") --status lineのカスタマイズ
	-- completion
	use("williamboman/mason.nvim") --lsp-installerの後継
	use("williamboman/mason-lspconfig.nvim") --lspconfigとの差分を吸収
	use("neovim/nvim-lspconfig") --lsp設定
	use("L3MON4D3/LuaSnip") --nvim-cmp用
	use("saadparwaiz1/cmp_luasnip") --nvim-cmp用
	use("VonHeikemen/lsp-zero.nvim") --lspのall-in-one設定
	use("hrsh7th/cmp-nvim-lsp")
	use("hrsh7th/cmp-nvim-lua")
	use("hrsh7th/cmp-buffer")
	use("hrsh7th/cmp-path")
	use("hrsh7th/cmp-cmdline")
	use("hrsh7th/nvim-cmp")
	use("windwp/nvim-autopairs")
	use("j-hui/fidget.nvim") --lspの進捗を表示
	use("folke/lsp-colors.nvim") --lspの色をカラフルに
	use("onsails/lspkind.nvim") --補完にアイコンを表示
	use({ "glepnir/lspsaga.nvim", branch = "main" })

	use("jose-elias-alvarez/null-ls.nvim")

	use({ "lambdalisue/fern.vim", branch = "main" }) --ファイラー
	use("lambdalisue/fern-git-status.vim") --fernでgit差分を表示
	use("lambdalisue/fern-renderer-nerdfont.vim") --fernでアイコンを表示
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" }) --構文解析によるsyntax highlight
	use("JoosepAlviste/nvim-ts-context-commentstring") --treesitterによるコメントアウト, vim-commentaryと合わせて使う
	use("numToStr/Comment.nvim") --範囲コメントアウト 選択行gcc vモードgc
	use("Vimjas/vim-python-pep8-indent") --pep8準拠のインデント
	use("lukas-reineke/indent-blankline.nvim") --インデントを可視化
	use("mhinz/vim-startify") --起動時のスタートメニューを追加
	use("lambdalisue/nerdfont.vim") --Nerd font
	use("hrsh7th/vim-searchx") --標準の検索をoverwrite
	use("phaazon/hop.nvim") --easymotionのlua版 ss
	use("terryma/vim-expand-region") --visualmodeの範囲拡張 Jで縮小, Kで拡張
	use("norcalli/nvim-colorizer.lua") -- 色コードをその色に変換
	use("lambdalisue/suda.vim") -- sudo権限でのread/writeを追加(SudaRead/SudaWrite)
	-- colorschemes
	use({ "dracula/vim", as = "dracula" })
	use({ "sainnhe/gruvbox-material", as = "gruvbox-material" })
	use({ "cocopon/iceberg.vim", as = "iceberg" })
	use({ "Mofiqul/vscode.nvim", as = "codedark" })
	use({ "EdenEast/nightfox.nvim", as = "nightfox" })
	use({ "folke/tokyonight.nvim", as = "tokyonight" })
	use({ "sainnhe/everforest", as = "everforest" })
end)

if do_sync then
	jetpack.sync()
end
