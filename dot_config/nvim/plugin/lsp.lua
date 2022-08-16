-----------------------------------------------------------
-- LSP config
-----------------------------------------------------------
local status1, mason = pcall(require, "mason.settings")
if not status1 then
	return
end
local status2, lsp = pcall(require, "lsp-zero")
if not status2 then
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

lsp.preset("lsp-compe")
lsp.set_preferences({
	set_lsp_keymaps = false,
	configure_diagnostics = false,
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