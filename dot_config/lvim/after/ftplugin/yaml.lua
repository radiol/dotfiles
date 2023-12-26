local formatter = require("lvim.lsp.null-ls.formatters")
-- local linter = require("lvim.lsp.null-ls.linters")

formatter.setup({ { name = "yamlfmt" } })
-- linter.setup({ { name = "yamllint" } })
