-----------------------------------------------------------
-- noice.nvim configuration by Radiol
-----------------------------------------------------------
return {
  {
    "noice.nvim",
    opts = {
      presets = {
        bottom_search = false,
      },
      -- Don't show code actions from null-ls
      -- 改行のたびにnull-lsがcode actionを出してくるので、それを抑制する
      routes = {
        {
          filter = {
            event = "lsp",
            find = "code_action null%-ls",
          },
          opts = { skip = true },
        },
      },
    },
  },
}
