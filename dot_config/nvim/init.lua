require("install-jetpack")

require("base")
require("plugins")
require("color")
require("keymap")

require("lsp")
require("nullls")
require("nvim-cmp")
-----------------------------------------------------------
-- Fidget setting
-----------------------------------------------------------
require("fidget").setup()

-----------------------------------------------------------
-- nvim-autopairs setting
-----------------------------------------------------------
require("nvim-autopairs").setup()

-----------------------------------------------------------
-- lspsaga setting
-----------------------------------------------------------
local opts = { noremap = true, silent = true }
vim.keymap.set("n", "<C-j>", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "<C-k>", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)

-----------------------------------------------------------
-- Telescope setting
-----------------------------------------------------------
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files)
vim.keymap.set("n", "<leader>fg", builtin.live_grep)
vim.keymap.set("n", "<leader>fb", builtin.buffers)
vim.keymap.set("n", "<leader>fh", builtin.help_tags)

-----------------------------------------------------------
-- Treesitter setting
-----------------------------------------------------------
require("nvim-treesitter.configs").setup({
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

-----------------------------------------------------------
-- Comment.nvim setting
-----------------------------------------------------------
require("Comment").setup()

-----------------------------------------------------------
-- Fern setting
-----------------------------------------------------------
vim.cmd([[
let g:fern#renderer = "nerdfont"
]])
vim.keymap.set("n", "<C-f>", "<cmd>Fern %:h -reveal=% -drawer -toggle<CR>")

-----------------------------------------------------------
-- Indent blankline setting
-----------------------------------------------------------
vim.opt.list = true
vim.opt.listchars:append("space:⋅")
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup({
	show_current_context = true,
	show_current_context_start = true,
	space_char_blankline = " ",
})

-----------------------------------------------------------
-- Vim-searchx setting
-----------------------------------------------------------
vim.cmd([[
" Overwrite / and ?.
nnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
nnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
xnoremap ? <Cmd>call searchx#start({ 'dir': 0 })<CR>
xnoremap / <Cmd>call searchx#start({ 'dir': 1 })<CR>
cnoremap ; <Cmd>call searchx#select()<CR>

" Move to next/prev match.
nnoremap N <Cmd>call searchx#prev_dir()<CR>
nnoremap n <Cmd>call searchx#next_dir()<CR>
xnoremap N <Cmd>call searchx#prev_dir()<CR>
xnoremap n <Cmd>call searchx#next_dir()<CR>
nnoremap <C-k> <Cmd>call searchx#prev()<CR>
nnoremap <C-j> <Cmd>call searchx#next()<CR>
xnoremap <C-k> <Cmd>call searchx#prev()<CR>
xnoremap <C-j> <Cmd>call searchx#next()<CR>
cnoremap <C-k> <Cmd>call searchx#prev()<CR>
cnoremap <C-j> <Cmd>call searchx#next()<CR>

" Clear highlights
nnoremap <C-l> <Cmd>call searchx#clear()<CR>

let g:searchx = {}

" Auto jump if the recent input matches to any marker.
let g:searchx.auto_accept = v:true

" The scrolloff value for moving to next/prev.
let g:searchx.scrolloff = &scrolloff

" To enable scrolling animation.
let g:searchx.scrolltime = 500

" To enable auto nohlsearch after cursor is moved
let g:searchx.nohlsearch = {}
let g:searchx.nohlsearch.jump = v:true

" Marker characters.
let g:searchx.markers = split('ABCDEFGHIJKLMNOPQRSTUVWXYZ', '.\zs')

" Convert search pattern.
function g:searchx.convert(input) abort
  if a:input !~# '\k'
    return '\V' .. a:input
  endif
  return a:input[0] .. substitute(a:input[1:], '\\\@<! ', '.\\{-}', 'g')
endfunction
]])

-----------------------------------------------------------
-- Hop setting
-----------------------------------------------------------
local hop = require("hop")
hop.setup()
vim.keymap.set("n", "ss", hop.hint_words)
vim.keymap.set("n", "ll", hop.hint_lines)

-----------------------------------------------------------
-- Vim-expand-region setting
-----------------------------------------------------------
vim.keymap.set("v", "<C-k>", "<Plug>(expand_region_expand)")
vim.keymap.set("v", "<C-j>", "<Plug>(expand_region_shrink)")

-----------------------------------------------------------
-- Lualine setting
-----------------------------------------------------------
require("lualine").setup()
