-----------------------------------------------------------
-- lspsaga setting
-----------------------------------------------------------
local status, saga = pcall(require, "lspsaga")
if not status then
	return
end

saga.setup({})

local opts = { noremap = true, silent = true }
-- lsp
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "gs", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga goto_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
-- diagnostic
vim.keymap.set("n", "gl", "<Cmd>Lspsaga show_line_diagnostics<CR>")
vim.keymap.set("n", "d]", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "d[", "<Cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
