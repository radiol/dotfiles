-----------------------------------------------------------
-- Install Vim-Jetpack
-----------------------------------------------------------
local jetpack_root = vim.fn.expand("~/.cache") .. "/jetpack-vim"
local jetpack_vim = jetpack_root .. "/jetpack.vim"
if vim.fn.filereadable(jetpack_vim) == 0 then
	vim.fn.execute(
		"!curl -fLo "
			.. jetpack_vim
			.. " --create-dirs https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
	)
end
vim.fn.execute("source " .. jetpack_vim)

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
require("jetpack").startup(function(use)
	use({ "tani/vim-jetpack", opt = 1 })
	use("vim-jp/vimdoc-ja") -- vim help 日本語化
	use("junegunn/fzf.vim")
	use({ "junegunn/fzf", run = "call fzf#install()" })
	use("nvim-lua/plenary.nvim") --telescope, null-lsに必要
	use("nvim-telescope/telescope.nvim") --fuzzy finder
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
	use("https://git.sr.ht/~whynothugo/lsp_lines.nvim")

	-- colorschemes
	use({ "dracula/vim", as = "dracula" })
	use({ "sainnhe/gruvbox-material", as = "gruvbox-material" })
	use({ "cocopon/iceberg.vim", as = "iceberg" })
	use({ "Mofiqul/vscode.nvim", as = "codedark" })
	use({ "EdenEast/nightfox.nvim", as = "nightfox" })
	use({ "folke/tokyonight.nvim", as = "tokyonight" })
	use({ "sainnhe/everforest", as = "everforest" })
end)

-----------------------------------------------------------
-- colorscheme
-----------------------------------------------------------
vim.cmd([[colorscheme tokyonight]])

-----------------------------------------------------------
-- General setting
-----------------------------------------------------------
local opt = vim.opt

opt.encoding = "utf-8"
opt.mouse = "a"
opt.number = true
opt.writebackup = false
opt.backup = false
opt.swapfile = false
opt.autoread = true
opt.smartindent = true
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.cmdheight = 2
opt.clipboard = "unnamedplus"

opt.ignorecase = true
opt.smartcase = true
opt.wrapscan = true
opt.incsearch = true
opt.hlsearch = true

-- 前回のカーソル位置を復元
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})

-- Diagnostic
-- disable virtual text
-- vim.diagnostic.config({ virtual_text = false })
-- change icons
-- local signs = {
-- 	Error = "",
-- 	Warn = "",
-- 	Hint = "",
-- 	Info = "",
-- }

-- for type, icon in pairs(signs) do
-- 	local hl = "DiagnosticSign" .. type
-- 	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-- Keymap
local set = vim.keymap.set
vim.g.mapleader = " "
set("i", "jj", "<Esc>")

-- Format on save
-- vim.cmd [[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]

-----------------------------------------------------------
-- null-ls setting
-----------------------------------------------------------
local formatting = require("null-ls").builtins.formatting
local diagnostics = require("null-ls").builtins.diagnostics

local sources = {
	formatting.stylua,
	formatting.black,
	formatting.isort,
	diagnostics.pyproject_flake8,
	diagnostics.mypy,
}

local lsp_formatting = function(bufnr)
	vim.lsp.buf.format({
		filter = function(client)
			-- apply whatever logic you want (in this example, we'll only use null-ls)
			return client.name == "null-ls"
		end,
		bufnr = bufnr,
	})
end

-- if you want to set up formatting on save, you can use this as a callback
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- add to your shared on_attach callback
local on_attach = function(client, bufnr)
	if client.supports_method("textDocument/formatting") then
		vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
		vim.api.nvim_create_autocmd("BufWritePre", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				lsp_formatting(bufnr)
			end,
		})
	end
end

require("null-ls").setup({
	sources = sources,
	on_attach = on_attach,
})

-----------------------------------------------------------
-- LSP setting
-----------------------------------------------------------
-- Mason setting
require("mason.settings").set({
	ui = {
		border = "rounded",
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local lsp = require("lsp-zero")
lsp.preset("lsp-only")
-- lua language server config
lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

lsp.setup()

-- -----------------------------------------------------------
-- -- Nvim-cmp setting
-- -----------------------------------------------------------
local cmp = require("cmp")

cmp.setup({
	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body) -- For `luasnip` users.
		end,
	},
	window = {
		completion = cmp.config.window.bordered(),
		documentation = cmp.config.window.bordered(),
	},
	mapping = cmp.mapping.preset.insert({
		["<C-b>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			else
				fallback()
			end
		end,
		["<S-Tab>"] = function(fallback)
			if cmp.visible() then
				cmp.select_prev_item()
			else
				fallback()
			end
		end,
	}),
	sources = cmp.config.sources({
		{ name = "nvim_lsp" },
		{ name = "luasnip" }, -- For luasnip users.
	}, {
		{ name = "buffer" },
	}),
})

-- Set configuration for specific filetype.
cmp.setup.filetype("gitcommit", {
	sources = cmp.config.sources({
		{ name = "cmp_git" }, -- You can specify the `cmp_git` source if you were installed it.
	}, {
		{ name = "buffer" },
	}),
})

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline("/", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})

-----------------------------------------------------------
-- Fidget setting
-----------------------------------------------------------
require("fidget").setup()

-----------------------------------------------------------
-- nvim-autopairs setting
-----------------------------------------------------------
require("nvim-autopairs").setup()
-----------------------------------------------------------
-- lsp-lines setting
-----------------------------------------------------------
-- local lsp_lines = require("lsp_lines")
-- lsp_lines.setup()
-- set("", "<leader>ll", lsp_lines.toggle)

-----------------------------------------------------------
-- Telescope setting
-----------------------------------------------------------
local builtin = require("telescope.builtin")
set("n", "<leader>ff", builtin.find_files)
set("n", "<leader>fg", builtin.live_grep)
set("n", "<leader>fb", builtin.buffers)
set("n", "<leader>fh", builtin.help_tags)

-----------------------------------------------------------
-- Treesitter setting
-----------------------------------------------------------
require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all"
	ensure_installed = { "python" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "javascript" },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,

		-- NOTE: these are the names of the parsers and not the filetype. (for example if you want to
		-- disable highlighting for the `tex` filetype, you need to include `latex` in this list as this is
		-- the name of the parser)
		-- list of language that will be disabled
		--disable = { "c", "rust" },

		-- Setting this to true will run `:h syntax` and tree-sitter at the same time.
		-- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
		-- Using this option may slow down your editor, and you may see some duplicate highlights.
		-- Instead of true it can also be a list of languages
		additional_vim_regex_highlighting = false,
	},
	-- nvim-ts-context-commentstring Setting
	context_commentstring = {
		enable = true,
	},
})

-----------------------------------------------------------
-- Comment.nvim setting
-----------------------------------------------------------
require("Comment").setup()

-----------------------------------------------------------
-- Fern setting
-----------------------------------------------------------
vim.cmd([[
let g:fern#renderer = "nerdfont"
]])
set("n", "<C-f>", "<cmd>Fern %:h -reveal=% -drawer -toggle<CR>")

-----------------------------------------------------------
-- Indent blankline setting
-----------------------------------------------------------
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	show_current_context = true,
	show_current_context_start = true,
	space_char_blankline = " ",
})

-----------------------------------------------------------
-- Vim-searchx setting (INCOMPLETE)
-----------------------------------------------------------
-- Overwrite / and ?
set("n", "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>", { noremap = true })
set("n", "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>", { noremap = true })
set("x", "?", "<Cmd>call searchx#start({ 'dir': 0 })<CR>", { noremap = true })
set("x", "/", "<Cmd>call searchx#start({ 'dir': 1 })<CR>", { noremap = true })
set("c", ";", "<Cmd>call searchx#select()<CR>", { noremap = true })

-----------------------------------------------------------
-- Hop setting
-----------------------------------------------------------
local hop = require("hop")
hop.setup()
set("n", "ss", hop.hint_words)
set("n", "ll", hop.hint_lines)

-----------------------------------------------------------
-- Vim-expand-region setting
-----------------------------------------------------------
set("v", "<C-k>", "<Plug>(expand_region_expand)")
set("v", "<C-j>", "<Plug>(expand_region_shrink)")

-----------------------------------------------------------
-- Lualine setting
-----------------------------------------------------------
require("lualine").setup()
