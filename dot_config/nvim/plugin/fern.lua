-----------------------------------------------------------
-- Fern setting
-----------------------------------------------------------
vim.g["fern#renderer"] = "nvim-web-devicons"
vim.keymap.set("n", "<C-f>", "<cmd>Fern %:h -reveal=% -drawer -toggle<CR>")
