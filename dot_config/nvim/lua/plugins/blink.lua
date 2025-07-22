return {
  "blink.cmp",
  dependencies = {
    "fang2hou/blink-copilot",
    "mikavilpas/blink-ripgrep.nvim",
    "folke/lazydev.nvim",
  },
  event = "InsertEnter",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      default = { "copilot", "snippets", "lsp", "ripgrep", "path", "buffer" },
      per_filetype = {
        lua = { inherit_defaults = true, "lazydev" },
      },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
        ripgrep = {
          module = "blink-ripgrep",
          name = "Ripgrep",
        },
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 200,
        },
      },
    },
    completion = {
      ghost_text = { enabled = true },
      list = { selection = { preselect = false, auto_insert = false } },
    },
    cmdline = {
      enabled = true,
      completion = {
        menu = {
          -- 検索時は補完を表示しない
          auto_show = function() return vim.fn.getcmdtype() ~= "/" end,
        },
        list = { selection = { preselect = false, auto_insert = true } },
      },
    },
  },
  opts_extend = { "sources.default" },
}
