return {
  "AstroNvim/astrocommunity",
  --colorscheme
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  --Language Pack
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  { import = "astrocommunity.pack.rust" },
  --Editing Support
  { import = "astrocommunity.editing-support.suda-vim" },
  --Utility
  { import = "astrocommunity.utility.noice-nvim" },
}
