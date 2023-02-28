return {
	{
		"zbirenbaum/copilot.lua",
		-- cmd = "Copilot",
		event = "VimEnter",
		config = function()
			vim.defer_fn(function()
				require("copilot").setup({
					suggestion = {
						auto_trigger = true,
						keymap = {
							accept = "<leader><CR><CR>",
						},
					},
				})
			end, 100)
		end,
	},
	{
		"VonHeikemen/lsp-zero.nvim",
		lazy = true,
		branch = "v1.x",
		dependencies = {
			-- LSP Support
			{ "neovim/nvim-lspconfig" }, -- Required
			{ "williamboman/mason.nvim" }, -- Optional
			{ "williamboman/mason-lspconfig.nvim" }, -- Optional
			{ "windwp/nvim-autopairs" },

			-- Autocompletion
			{
				"hrsh7th/nvim-cmp",
				dependencies = {
					{ "hrsh7th/cmp-nvim-lsp" }, -- Required
					{ "hrsh7th/cmp-buffer" }, -- Optional
					{ "hrsh7th/cmp-path" }, -- Optional
					{ "saadparwaiz1/cmp_luasnip" }, -- Optional
					{ "hrsh7th/cmp-nvim-lua" }, -- Optional
					{ "hrsh7th/cmp-cmdline" },
					-- copilot
					{
						"zbirenbaum/copilot-cmp",
						config = function()
							require("copilot_cmp").setup()
						end,
					},
					-- Snippets
					{ "L3MON4D3/LuaSnip" }, -- Required
					{ "rafamadriz/friendly-snippets" }, -- Optional
					{ "onsails/lspkind.nvim" }, --補完にアイコンを表示
				},
			}, -- Required
		},
		event = "VimEnter",
		config = function()
			local mason = require("mason.settings")
			local cmp = require("cmp")
			local lsp = require("lsp-zero")
			local lspkind = require("lspkind")
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")

			mason.set({
				ui = {
					border = "rounded",
					icons = {
						package_installed = "✓",
						package_pending = "➜",
						package_uninstalled = "✗",
					},
				},
			})

			lsp.preset({
				name = "minimal",
				set_lsp_keymaps = true,
				manage_nvim_cmp = true,
				suggest_lsp_servers = false,
				configure_diagnostics = false,
				sign_icons = {
					error = "",
					warn = "",
					hint = "",
					info = "",
				},
			})

			lsp.setup_nvim_cmp({
				formatting = {
					format = lspkind.cmp_format({
						mode = "symbol_text",
						maxwidth = 50,
						symbol_map = { Copilot = "" },
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
				sources = {
					{ name = "copilot" },
					{ name = "nvim_lsp", group_index = 2 },
					{ name = "path", group_index = 2 },
					{ name = "buffer", group_index = 2 },
					{ name = "luasnip", group_index = 2 },
					-- { name = "nvim_lua", group_index = 2 },
					{ name = "cmdline" },
				},
			})

			lsp.setup_nvim_cmp({
				preselect = "none",
				completion = {
					completeopt = "menu,meruone,noinsert,noselect",
				},
			})

			lsp.ensure_installed({
				"lua_ls",
			})

			-- lua language server config
			lsp.configure("lua_ls", {
				settings = {
					Lua = {
						diagnostics = { globals = { "vim" } },
					},
				},
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

			-- Insert `(` after select function or method item
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

			lsp.nvim_workspace()

			lsp.setup()
		end,
	}, --lspのall-in-one設定
	{ "folke/lsp-colors.nvim" }, --lspの色をカラフルに
}
