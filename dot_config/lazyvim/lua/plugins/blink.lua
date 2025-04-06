return {
  "saghen/blink.cmp",
  event = { "InsertEnter", "CmdLineEnter" },
  dependencies = { "rafamadriz/friendly-snippets" },
  version = "*",
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    keymap = { preset = "enter" },
    sources = { default = { "lsp", "path", "snippets", "buffer" } },
    completion = {
      ghost_text = { enabled = true },
      list = { selection = { preselect = false, auto_insert = false } },
    },
    cmdline = {
      completion = {
        menu = {
          auto_show = true,
        },
        list = {
          selection = {
            preselect = false,
            auto_insert = true,
          },
        },
      },
      keymap = {
        preset = "enter",
      },
    },
  },
}
