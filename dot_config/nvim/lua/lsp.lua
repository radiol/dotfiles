-----------------------------------------------------------
-- LSP config
-----------------------------------------------------------
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
