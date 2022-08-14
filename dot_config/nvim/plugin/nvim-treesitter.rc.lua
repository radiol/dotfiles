-----------------------------------------------------------
-- Treesitter setting
-----------------------------------------------------------
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

treesitter.setup({
	-- A list of parser names, or "all"
	ensure_installed = { "python" },

	-- Install parsers synchronously (only applied to `ensure_installed`)
	sync_install = false,

	-- Automatically install missing parsers when entering buffer
	auto_install = true,

	-- List of parsers to ignore installing (for "all")
	ignore_install = { "javascript" },

	highlight = {
		-- `false` will disable the whole extension
		enable = true,
		additional_vim_regex_highlighting = false,
	},
	indent = {
		enable = true,
	},
	-- nvim-ts-context-commentstring Setting
	context_commentstring = {
		enable = true,
	},
})
