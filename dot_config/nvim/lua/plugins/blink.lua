return {
  "blink.cmp",
  dependencies = { "fang2hou/blink-copilot" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      ghost_text = { enabled = true },
      list = { selection = { preselect = false, auto_insert = false } },
    },
    cmdline = {
      enabled = true,
      completion = {
        menu = {
          auto_show = true,
        },
        list = { selection = { preselect = false, auto_insert = true } },
      },
    },
  },
}
