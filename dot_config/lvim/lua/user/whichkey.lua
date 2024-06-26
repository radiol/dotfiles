-- WhichKey Mapping
lvim.builtin.which_key.mappings["W"] = {
	"<cmd>:SudaWrite<cr>",
	"SudaWrite",
}
lvim.builtin.which_key.mappings["O"] = {
	"<cmd>:Oil<cr>",
	"Open Oil",
}
lvim.builtin.which_key.mappings["e"] = {
	"<cmd>:NeoTreeRevealToggle<cr>",
	"NeoTree",
}
lvim.builtin.which_key.mappings["t"] = {
	name = "Diagnostics",
	t = { "<cmd>TroubleToggle<cr>", "trouble" },
	w = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "workspace" },
	d = { "<cmd>TroubleToggle document_diagnostics<cr>", "document" },
	q = { "<cmd>TroubleToggle quickfix<cr>", "quickfix" },
	l = { "<cmd>TroubleToggle loclist<cr>", "loclist" },
	r = { "<cmd>TroubleToggle lsp_references<cr>", "references" },
}
