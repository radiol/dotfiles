--vim opt
vim.opt.termguicolors = true

lvim.colorscheme = "tokyonight"

lvim.format_on_save.enabled = true
lvim.builtin.terminal.open_mapping = "<c-t>"
lvim.builtin.nvimtree.active = false -- NOTE: using neo-tree

-- Skip rust_analyzer for rustaceanvim
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "rust_analyzer" })
