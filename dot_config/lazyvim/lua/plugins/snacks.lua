return {
  "snacks.nvim",
  ---@type snacks.Config
  opts = {
    indent = {
      enabled = true,
      chunk = {
        enabled = true,
        char = {
          -- corner_top = "┌",
          -- corner_bottom = "└",
          corner_top = "╭",
          corner_bottom = "╰",
          horizontal = "─",
          vertical = "│",
          arrow = ">",
        },
      },
      animate = {
        enabled = true,
        style = "down",
      },
    },
  },
}
