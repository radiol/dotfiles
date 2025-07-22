return {
  "folke/noice.nvim",
  opts = {
    routes = {
      {
        filter = {
          event = "lsp",
          kind = "progress",
          find = "code_action", -- メッセージに "code_action" を含むものを対象
        },
        opts = { skip = true }, -- 表示しない
      },
    },
  },
}
