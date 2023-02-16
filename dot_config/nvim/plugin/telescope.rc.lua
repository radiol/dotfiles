-----------------------------------------------------------
-- Telescope setting
-----------------------------------------------------------
local status, telescope = pcall(require, "telescope")
if not status then
	return
end

local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local function telescope_buffer_dir()
	return vim.fn.expand("%:p:h")
end

local fb_actions = telescope.extensions.file_browser.actions

-- enable telescope-file-browser
telescope.setup({
	defaults = {
		mappings = {
			n = {
				["q"] = actions.close,
			},
		},
	},
	extensions = {
		file_browser = {
			theme = "dropdown",
			hijack_netrw = true,
			mappings = {
				["i"] = {
					["C-w"] = function()
						vim.cmd("normal vbd")
					end,
				},
				["n"] = {
					["N"] = fb_actions.create,
					[".."] = fb_actions.goto_parent_dir,
					["/"] = function()
						vim.cmd("startinsert")
					end,
				},
			},
		},
		-- 検索をfzfへ変更
		fzf = {
			fuzzy = true, -- false will only do exact matching
			override_generic_sorter = true, -- override the generic sorter
			override_file_sorter = true, -- override the file sorter
			case_mode = "smart_case", -- or "ignore_case" or "respect_case"
			-- the default case_mode is "smart_case"
		},
	},
})
-- setup fzf
telescope.load_extension("fzf")

-- File Browser
telescope.load_extension("file_browser")
vim.keymap.set("n", "<leader>fs", function()
	telescope.extensions.file_browser.file_browser({
		path = "%:p:h",
		cwd = telescope_buffer_dir(),
		respect_gitignore = false,
		hidden = true,
		grouped = true,
		previewer = false,
		initial_mode = "normal",
		layout_config = { height = 40 },
	})
end)

-- Open Frequent file
telescope.load_extension("frecency")
vim.api.nvim_set_keymap(
	"n",
	"<leader><leader>",
	"<Cmd>lua require('telescope').extensions.frecency.frecency()<CR>",
	{ noremap = true, silent = true }
)

-- set keymap
vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
