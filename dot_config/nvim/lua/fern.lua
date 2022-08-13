-----------------------------------------------------------
-- Fern setting
-----------------------------------------------------------
vim.cmd([[
let g:fern#renderer = "nerdfont"
]])
vim.keymap.set("n", "<C-f>", "<cmd>Fern %:h -reveal=% -drawer -toggle<CR>")
