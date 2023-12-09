return {
  "AstroNvim/astrocommunity",
  -- colorscheme
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.everforest" },
  { import = "astrocommunity.colorscheme.catppuccin" },

  -- Copilot
  { import = "astrocommunity.completion.copilot-lua-cmp" },

  -- Language Pack
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.python-ruff" },
  {
    "linux-cultist/venv-selector.nvim",
    opts = { name = { "venv", ".venv" } },
  },
  {
    import = "astrocommunity.pack.rust",
    lsp = {
      config = {
        rust_analyzer = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                loadOutDirsFromCheck = true,
                features = "all",
              },
              checkOnSave = {
                command = "clippy",
              },
            },
          },
        },
      },
    },
  },
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
}
