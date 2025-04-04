-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
  "AstroNvim/astrocommunity",
  -- colorscheme
  { import = "astrocommunity.colorscheme.catppuccin" },
  { import = "astrocommunity.colorscheme.tokyonight-nvim" },
  { import = "astrocommunity.colorscheme.everforest" },

  -- Language Pack
  { import = "astrocommunity.pack.bash" },
  { import = "astrocommunity.pack.docker" },
  { import = "astrocommunity.pack.go" },
  { import = "astrocommunity.pack.lua" },
  { import = "astrocommunity.pack.markdown" },
  { import = "astrocommunity.pack.python-ruff" },
  { import = "astrocommunity.pack.rust" },
  { import = "astrocommunity.pack.toml" },
  { import = "astrocommunity.pack.yaml" },

  -- Completion
  { import = "astrocommunity.completion.avante-nvim" },

  -- Editing Support
  -- <leader> + Shift + w: Sudo write
  { import = "astrocommunity.editing-support.suda-vim" },
  -- Ctrl + a or x: Increment/Decrement
  { import = "astrocommunity.editing-support.dial-nvim" },
  -- Replace nvim-autopairs
  { import = "astrocommunity.editing-support.ultimate-autopair-nvim" },

  -- Indent
  { import = "astrocommunity.indent.snacks-indent-hlchunk" },

  -- LSP
  { import = "astrocommunity.lsp.lspsaga-nvim" },
  { import = "astrocommunity.lsp.nvim-lint" },

  -- Motion
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

  -- Recipe
  { import = "astrocommunity.recipes.cache-colorscheme" },

  -- Search
  { import = "astrocommunity.search.grug-far-nvim" },

  -- Utility
  { import = "astrocommunity.utility.noice-nvim" },

  -- Diagnostic
  { import = "astrocommunity.diagnostics.tiny-inline-diagnostic-nvim" },
  -- Markdown
  { import = "astrocommunity.markdown-and-latex.render-markdown-nvim" },
}
