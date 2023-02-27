-----------------------------------------------------------
-- LSP config
-----------------------------------------------------------
local status1, mason = pcall(require, "mason.settings")
if not status1 then
	return
end
local status2, cmp = pcall(require, "cmp")
if not status2 then
	return
end
local status3, lsp = pcall(require, "lsp-zero")
if not status3 then
	return
end
local status4, lspkind = pcall(require, "lspkind")
if not status4 then
	return
end
local status5, cmp_autopairs = pcall(require, "nvim-autopairs.completion.cmp")
if not status5 then
	return
end

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
