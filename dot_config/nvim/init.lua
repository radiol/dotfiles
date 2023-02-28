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

opt.termguicolors = true

vim.wo.signcolumn = "yes"
-- 前回のカーソル位置を復元
vim.api.nvim_create_autocmd({ "BufReadPost" }, {
	pattern = { "*" },
	callback = function()
		vim.api.nvim_exec('silent! normal! g`"zv', false)
	end,
})
-- disable virtual text
vim.diagnostic.config({
	virtual_text = false,
})
-- change diagnostic icons
-- local signs = {
-- 	Error = "",
-- 	Warn = "",
-- 	Hint = "",
-- 	Info = "",
-- }
-- for type, icon in pairs(signs) do
-- 	local hl = "diagnosticsign" .. type
-- vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
-- end

-----------------------------------------------------------
-- Keymap
-----------------------------------------------------------
vim.g.mapleader = " " -- -> リーダーキーの設定はlazy.nvimの設定より先
vim.keymap.set("i", "jj", "<Esc>")

-----------------------------------------------------------
-- Install lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)
-----------------------------------------------------------
-- Load plugins
-----------------------------------------------------------
require("lazy").setup("plugins")
