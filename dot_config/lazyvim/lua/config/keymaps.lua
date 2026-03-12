-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local map = vim.keymap.set

--local uname = vim.uv.os_uname()

map({ "n", "t" }, "<C-t>", function()
  Snacks.terminal.toggle(nil, { win = { position = "float" } })
end, { desc = "Toggle floating terminal" })
