-- Read the docs: https://www.lunarvim.org/docs/configuration
-- Example configs: https://github.com/LunarVim/starter.lvim
-- Video Tutorials: https://www.youtube.com/watch?v=sFA9kX-Ud_c&list=PLhoH5vyxr6QqGu0i7tt_XoVK9v-KvZ3m6
-- Forum: https://www.reddit.com/r/lunarvim/
-- Discord: https://discord.com/invite/Xb9B4Ny
-- lvim.colorscheme = "tokyonight"

lvim.format_on_save.enabled = true
lvim.colorscheme = "catppuccin-frappe"

lvim.plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },

  {
    "lambdalisue/suda.vim",
    keys = { {
      "<leader>W", "<cmd>:SudaWrite<cr>",
    } }
  },
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    opts = {
      -- add any options here
    },
    dependencies = {
      -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
      "MunifTanjim/nui.nvim",
      -- OPTIONAL:
      --   `nvim-notify` is only needed, if you want to use the notification view.
      --   If not available, we use `mini` as the fallback
      "rcarriga/nvim-notify",
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
    dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim" },
    config = true,
    event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
    keys = { {
      "<leader>lv", "<cmd>:VenvSelect<cr>",
      -- key mapping for directly retrieve from cache. You may set autocmd if you prefer the no hand approach
      -- "<leader>vc", "<cmd>:VenvSelectCached<cr>"
    } },
    opts = {
      name = { "venv", ".venv" },
    },
  },
}
