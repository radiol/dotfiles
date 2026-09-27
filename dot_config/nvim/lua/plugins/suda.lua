return {
  "lambdalisue/vim-suda",
  -- smart_edit hooks into buffer reads, so the plugin must load at startup
  lazy = false,
  init = function()
    vim.g.suda_smart_edit = 1
  end,
}
