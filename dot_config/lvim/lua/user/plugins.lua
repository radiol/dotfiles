lvim.plugins = {
	{ "catppuccin/nvim", name = "catppuccin" },
	{ "morhetz/gruvbox" },
	{ "sainnhe/gruvbox-material" },
	{ "sainnhe/sonokai" },
	{ "sainnhe/edge" },
	{ "sainnhe/everforest" },
	{ "folke/tokyonight.nvim", priority = 1000 },
	{ "navarasu/onedark.nvim" },
	{ "EdenEast/nightfox.nvim" },
	{ "nordtheme/vim", name = "nordtheme" },
	{
		-- Copilot
		"zbirenbaum/copilot-cmp",
		event = "InsertEnter",
		dependencies = { "zbirenbaum/copilot.lua" },
		config = function()
			vim.defer_fn(function()
				-- https://github.com/zbirenbaum/copilot.lua/blob/master/README.md#setup-and-configuration
				require("copilot").setup()
				-- https://github.com/zbirenbaum/copilot-cmp/blob/master/README.md#configuration
				require("copilot_cmp").setup()
			end, 100)
		end,
	},
	{ "lambdalisue/suda.vim" },
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
		},
	},
	{
		"linux-cultist/venv-selector.nvim",
		dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
		config = true,
		event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
		keys = {
			{
				"<leader>lv",
				"<cmd>:VenvSelect<cr>",
				-- key mapping for directly retrieve from cache. You may set autocmd if you prefer the no hand approach
				-- "<leader>vc", "<cmd>:VenvSelectCached<cr>"
			},
		},
		opts = {
			name = { "venv", ".venv" },
		},
	},
	{
		-- "/"検索での検索結果にアルファベットのインデックスが追加
		-- 検索途中でそのアルファベットのキーを押すことでそこに飛ぶ
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{
				"s",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Flash",
			},
			{
				"S",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Flash Treesitter",
			},
			{
				"r",
				mode = "o",
				function()
					require("flash").remote()
				end,
				desc = "Remote Flash",
			},
			{
				"R",
				mode = { "o", "x" },
				function()
					require("flash").treesitter_search()
				end,
				desc = "Treesitter Search",
			},
			{
				"<c-s>",
				mode = { "c" },
				function()
					require("flash").toggle()
				end,
				desc = "Toggle Flash Search",
			},
		},
	},
	{
		-- :<row number> -> jump row
		"nacro90/numb.nvim",
		key = { { ":", mode = "n" } },
		config = function()
			require("numb").setup({
				show_numbers = true, -- Enable 'number' for the window while peeking
				show_cursorline = true, -- Enable 'cursorline' for the window while peeking
			})
		end,
	},
	{
		-- 色コードを強調表示
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup({ "css", "scss", "html", "javascript" }, {
				RGB = true, -- #RGB hex codes
				RRGGBB = true, -- #RRGGBB hex codes
				RRGGBBAA = true, -- #RRGGBBAA hex codes
				rgb_fn = true, -- CSS rgb() and rgba() functions
				hsl_fn = true, -- CSS hsl() and hsla() functions
				css = true, -- Enable all CSS features: rgb_fn, hsl_fn, names, RGB, RRGGBB
				css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn
			})
		end,
	},
	{
		-- smooth scrolling
		"karb94/neoscroll.nvim",
		event = "WinScrolled",
		config = function()
			require("neoscroll").setup({
				-- All these keys will be mapped to their corresponding default scrolling animation
				mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
				hide_cursor = true, -- Hide cursor while scrolling
				stop_eof = true, -- Stop at <EOF> when scrolling downwards
				use_local_scrolloff = false, -- Use the local scope of scrolloff instead of the global scope
				respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
				cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
				easing_function = nil, -- Default easing function
				pre_hook = nil, -- Function to run before the scrolling animation starts
				post_hook = nil, -- Function to run after the scrolling animation ends
			})
		end,
	},
	-- ------------------------------------------------------------
	-- yanky.nvim
	-- (https://github.com/gbprod/yanky.nvim)
	-- ------------------------------------------------------------
	{
		"gbprod/yanky.nvim",
		config = function()
			require("yanky").setup({})
			vim.keymap.set({ "n", "x" }, "p", "<Plug>(YankyPutAfter)")
			vim.keymap.set({ "n", "x" }, "P", "<Plug>(YankyPutBefore)")
			vim.keymap.set({ "n", "x" }, "gp", "<Plug>(YankyGPutAfter)")
			vim.keymap.set({ "n", "x" }, "gP", "<Plug>(YankyGPutBefore)")
			vim.keymap.set("n", "<M-,>", "<Plug>(YankyCycleForward)")
			vim.keymap.set("n", "<M-.>", "<Plug>(YankyCycleBackward)")
		end,
	},
	-- ------------------------------------------------------------
	-- rustaceanvim
	-- Supercharge your Rust experience in Neovim
	-- A heavily modified fork of rust-tools.nvim
	-- (https://github.com/mrcjkb/rustaceanvim)
	-- nvim0.9ではinlay hintsの表示にlsp_inlayhints.nvimが必要
	-- nvim0.10ではinlay hintsが組み込みになるので不要になる予定
	---------------------------------------------------------------
	{
		"mrcjkb/rustaceanvim",
		version = "^4",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"mfussenegger/nvim-dap",
			{
				"lvimuser/lsp-inlayhints.nvim", -- <- nvim0.10から不要
				opts = { enabled_at_startup = true },
			},
		},
		ft = { "rust" },
		config = function()
			vim.g.rustaceanvim = {
				inlay_hints = {
					highlight = "NonText",
				},
				tools = {
					hover_actions = {
						auto_focus = true,
					},
				},
				server = {
					on_attach = function(client, bufnr)
						require("lsp-inlayhints").on_attach(client, bufnr) -- <- nvim0.10から不要
					end,
					settings = {
						["rust-analyzer"] = {
							checkOnSave = {
								command = "clippy",
							},
						},
					},
				},
			}
		end,
	},
	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	---------------------------------------------------------------
	-- Neo-tree.nvim
	-- https://github.com/nvim-neo-tree/neo-tree.nvim
	---------------------------------------------------------------
	{
		"nvim-neo-tree/neo-tree.nvim",
		cmd = "NeoTreeRevealToggle",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("neo-tree").setup({
				close_if_last_window = true,
				window = {
					width = 30,
				},
				buffers = {
					follow_current_file = true,
				},
				filesystem = {
					follow_current_file = true,
					filtered_items = {
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_by_name = {
							"node_modules",
						},
						never_show = {
							".DS_Store",
							"thumbs.db",
						},
					},
				},
			})
		end,
	},
	{
		"iamcco/markdown-preview.nvim",
		build = "cd app && npm install",
		ft = "markdown",
		config = function()
			vim.g.mkdp_auto_start = 1
		end,
	},
	---------------------------------------------------------------
	-- https://github.com/stevearc/dressing.nvim
	---------------------------------------------------------------
	{
		"stevearc/dressing.nvim",
		opts = {},
	},
	---------------------------------------------------------------
	-- https://github.com/stevearc/oil.nvim
	---------------------------------------------------------------
	{
		"stevearc/oil.nvim",
		opts = {},
		-- Optional dependencies
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},
}
