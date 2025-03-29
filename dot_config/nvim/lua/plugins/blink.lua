return {
  "blink.cmp",
  dependencies = { "fang2hou/blink-copilot" },
  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
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
