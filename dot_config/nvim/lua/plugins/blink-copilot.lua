return {
  "fang2hou/blink-copilot",
  event = "InsertEnter",
  specs = {
    {
      "Saghen/blink.cmp",
      optional = true,
      opts = {
        sources = {
          -- enable the provider by default (automatically extends when merging tables)
          default = { "copilot" },
          providers = {
            -- Specific details depend on the blink source
            copilot = {
              name = "copilot",
              module = "blink-copilot",
              score_offset = 100,
              async = true,
            },
          },
        },
      },
    },
  },
}
