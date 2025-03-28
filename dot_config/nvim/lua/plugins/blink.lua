return {
  "blink.cmp",
  dependencies = { "fang2hou/blink-copilot" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    sources = {
      default = { "copilot", "lsp", "path", "snippets", "buffer" },
      providers = {
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
    cmdline = {
      enabled = true,
      completion = {
        menu = {
          auto_show = true,
        },
        list = { selection = { preselect = false } },
      },
    },
    completion = {
      list = { selection = { preselect = false } },
    },
  },
}
