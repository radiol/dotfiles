local manager = require "lvim.lsp.manager"
local formatter = require "lvim.lsp.null-ls.formatters"
local linter = require "lvim.lsp.null-ls.linters"

manager.setup("ruff_lsp")
formatter.setup { { name = "black" } }
linter.setup { { command = "ruff", filetypes = { "python" } } }
