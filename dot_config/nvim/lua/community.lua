return {
  "AstroNvim/astrocommunity",
  -- colorscheme
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Copilot
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- Language Pack
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },

  -- Completion
  { import = "astrocommunity.completion.cmp-cmdline" },

  -- Editing Support
  -- <leader> + Shift + w: Sudo write
  { import = "astrocommunity.editing-support.suda-vim" },
  -- Ctrl + a or x: Increment/Decrement
  { import = "astrocommunity.editing-support.dial-nvim" },
  -- Replace nvim-autopairs
  { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },

  -- LSP
  { import = "astrocommunity.lsp.lspsaga-nvim" },
  { import = "astrocommunity.lsp.nvim-lint" },

  -- Motion
  -- "/"検索での検索結果にアルファベットのインデックスが追加
  -- 検索途中でそのアルファベットのキーを押すことでそこに飛ぶ
  { import = "astrocommunity.motion.flash-nvim" },
  -- surround.nvim
  --     Old text                    Command         New text
  --------------------------------------------------------------------------------
  -- surr*ound_words             ysiw)           (surround_words)
  -- *make strings               ys$"            "make strings"
  -- [delete ar*ound me!]        ds]             delete around me!
  -- remove <b>HTML t*ags</b>    dst             remove HTML tags
  -- 'change quot*es'            cs'"            "change quotes"
  -- <b>or tag* types</b>        csth1<CR>       <h1>or tag types</h1>
  -- delete(functi*on calls)     dsf             function calls
  { import = "astrocommunity.motion.nvim-surround" },

  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },

  -- Diagnostic
  -- { import = "astrocommunity.diagnostics.lsp_lines-nvim" },
}
