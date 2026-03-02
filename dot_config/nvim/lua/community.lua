-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- Colorscheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  -- Language Pack
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python.ruff" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },
  -- Color
  { import = "astrocommunity.color.transparent-nvim" },
  -- Completion
  { import = "astrocommunity.completion.avante-nvim" },
  -- Diagnostic
  { import = "astrocommunity.diagnostics.tiny-inline-diagnostic-nvim" },
  -- Editing Support
  { import = "astrocommunity.editing-support.suda-vim" },
  { import = "astrocommunity.editing-support.dial-nvim" },
  { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },
  { import = "astrocommunity.editing-support.todo-comments-nvim" },
  { import = "astrocommunity.editing-support.yanky-nvim" },
  -- Indent
  { import = "astrocommunity.indent.snacks-indent-hlchunk" },
  -- LSP
  { import = "astrocommunity.lsp.lspsaga-nvim" },
  { import = "astrocommunity.lsp.nvim-lint" },
  -- Motion
  { import = "astrocommunity.motion.flash-nvim" },
  { import = "astrocommunity.motion.nvim-surround" },
  -- Recipe
  { import = "astrocommunity.recipes.heirline-mode-text-statusline" },
  { import = "astrocommunity.recipes.picker-lsp-mappings" },
  -- Scrolling
  { import = "astrocommunity.scrolling.nvim-scrollbar" },
  -- Search
  { import = "astrocommunity.search.grug-far-nvim" },
  -- Terminal
  { import = "astrocommunity.terminal-integration.flatten-nvim" },
  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },
}
