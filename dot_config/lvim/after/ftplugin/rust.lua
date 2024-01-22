local formatter = require("lvim.lsp.null-ls.formatters")

formatter.setup({ { name = "rustfmt" } })

lvim.builtin.which_key.mappings["r"] = {
	name = "Rustacean",
	r = { "<cmd>RustLsp runnables<cr>", "Runnable" },
	h = { "<cmd>lua require('lsp-inlayhints').toggle()<cr>", "Toggle inlay hints" },
}
