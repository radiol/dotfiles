return {
  "AstroNvim/astrocommunity",
  -- colorscheme
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },

  -- Language Pack
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  {
    "linux-cultist/venv-selector.nvim",
    opts = { name = { "venv", ".venv" } },
  },
  { import = "astrocommunity.pack.rust" },

  -- Editing Support
  -- <Leader> + Shift + w: Sudo write
  { import = "astrocommunity.editing-support.suda-vim" },
  -- Ctrl + a or x: Increment/decrement
  { import = "astrocommunity.editing-support.dial-nvim" },

  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },
}
