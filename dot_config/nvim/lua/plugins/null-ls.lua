return {
	{
		"jay-babu/mason-null-ls.nvim",
		dependencies = {
			{ "jose-elias-alvarez/null-ls.nvim" },
			{ "williamboman/mason.nvim" },
		},
		config = function()
			local null_ls = require("null-ls")
			local mason = require("mason")
			local mason_null_ls = require("mason-null-ls")

			-- for Neovim 0.8
			-- https://github.com/jose-elias-alvarez/null-ls.nvim/wiki/Formatting-on-save
			local lsp_formatting = function(bufnr)
				vim.lsp.buf.format({
					filter = function(client)
						-- apply whatever logic you want (in this example, we'll only use null-ls)
						return client.name == "null-ls"
					end,
					bufnr = bufnr,
				})
			end

			-- if you want to set up formatting on save, you can use this as a callback
			local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

			-- add to your shared on_attach callback
			local on_attach = function(client, bufnr)
				if client.supports_method("textDocument/formatting") then
					vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
					vim.api.nvim_create_autocmd("BufWritePre", {
						group = augroup,
						buffer = bufnr,
						callback = function()
							lsp_formatting(bufnr)
						end,
					})
				end
			end

			mason.setup()
			mason_null_ls.setup({
				ensure_installed = {
					"stylua",
				},
				automatic_installation = false,
				automatic_setup = true,
			})
			null_ls.setup({
				on_attach = on_attach,
			})

			mason_null_ls.setup_handlers()
		end,
	},
}
