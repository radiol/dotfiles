return {
  "AstroNvim/astrocommunity",
  -- colorscheme
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.everforest" },

  -- Language Pack
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python" },
  {
    "linux-cultist/venv-selector.nvim",
    opts = { name = { "venv", ".venv" } },
  },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },

  -- Editing Support
  -- <leader> + Shift + w: Sudo write
  { import = "astrocommunity.editing-support.suda-vim" },
  -- Ctrl + a or x: Increment/Decrement
  { import = "astrocommunity.editing-support.dial-nvim" },

  -- Motion
  -- "/"検索での検索結果にアルファベットのインデックスが追加
  -- 検索途中でそのアルファベットのキーを押すことでそこに飛ぶ
  { import = "astrocommunity.motion.flash-nvim" },

  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },
}
