-----------------------------------------------------------
-- Install Vim-Jetpack
-----------------------------------------------------------
local jetpack_url = "https://raw.githubusercontent.com/tani/vim-jetpack/master/plugin/jetpack.vim"
local jetpack_root = vim.fn.expand("~/.cache") .. "/jetpack-vim"
local jetpack_vim = jetpack_root .. "/jetpack.vim"
if vim.fn.filereadable(jetpack_vim) == 0 then
	vim.fn.execute("!curl -fLo " .. jetpack_vim .. " --create-dirs " .. jetpack_url)
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
	use("onsails/lspkind.nvim") --補完にアイコンを表示

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

-- Keymap
local set = vim.keymap.set
vim.g.mapleader = " "
set("i", "jj", "<Esc>")

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
lsp.preset("lsp-compe")
lsp.set_preferences({
	sign_icons = {
		error = "",
		warn = "",
		hint = "",
		info = "",
	},
})

-- lua language server config
lsp.configure("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = { globals = { "vim" } },
		},
	},
})

lsp.setup()

-----------------------------------------------------------
-- null-ls setting
-----------------------------------------------------------
local mason_package = require("mason-core.package")
local mason_registry = require("mason-registry")
local null_ls = require("null-ls")

local formatting = null_ls.builtins.formatting
local diagnostics = null_ls.builtins.diagnostics

local null_sources = {}
for _, package in ipairs(mason_registry.get_installed_packages()) do
	local package_categories = package.spec.categories[1]
	if package_categories == mason_package.Cat.Formatter then
		table.insert(null_sources, formatting[package.name])
	end
	if package_categories == mason_package.Cat.Linter then
		local linter = diagnostics[package.name]
		if package.name == "flake8" then
			linter = linter.with({
				extra_args = { "--max-line-length", "119", "--ignore", "E203,E741" },
			})
		end
		table.insert(null_sources, linter)
	end
end

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
	sources = null_sources,
	on_attach = on_attach,
})

-- -----------------------------------------------------------
-- -- Nvim-cmp setting
-- -----------------------------------------------------------
local cmp = require("cmp")
local lspkind = require("lspkind")

cmp.setup({
	formatting = {
		format = lspkind.cmp_format({
			mode = "symbol",
			maxwidth = 50,
		}),
	},
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
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
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
-- Vim-searchx setting
-----------------------------------------------------------
vim.cmd([[
" Overwrite / and ?.
nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
cnoremap ; <Cmd>call searchx#select()<CR>

" Move to next/prev match.
nnoremap N <Cmd>call searchx#prev_dir()<CR>
nnoremap n <Cmd>call searchx#next_dir()<CR>
xnoremap N <Cmd>call searchx#prev_dir()<CR>
xnoremap n <Cmd>call searchx#next_dir()<CR>
nnoremap <C-k> <Cmd>call searchx#prev()<CR>
nnoremap <C-j> <Cmd>call searchx#next()<CR>
xnoremap <C-k> <Cmd>call searchx#prev()<CR>
xnoremap <C-j> <Cmd>call searchx#next()<CR>
cnoremap <C-k> <Cmd>call searchx#prev()<CR>
cnoremap <C-j> <Cmd>call searchx#next()<CR>

" Clear highlights
nnoremap <C-l> <Cmd>call searchx#clear()<CR>

let g:searchx = {}

" Auto jump if the recent input matches to any marker.
let g:searchx.auto_accept = v:true

" The scrolloff value for moving to next/prev.
let g:searchx.scrolloff = &scrolloff

" To enable scrolling animation.
let g:searchx.scrolltime = 500

" To enable auto nohlsearch after cursor is moved
let g:searchx.nohlsearch = {}
let g:searchx.nohlsearch.jump = v:true

" Marker characters.
let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')

" Convert search pattern.
function g:searchx.convert(input) abort
  if a:input !~# '\k'
    return '\V' .. a:input
  endif
  return a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
endfunction
]])

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
