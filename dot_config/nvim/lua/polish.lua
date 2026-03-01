-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- クリップボード設定
-- X/Wayland環境またはmacOSではシステムクリップボード連携
-- それ以外(SSH先など)ではOSC 52でcopyのみ対応(pasteはセキュリティ上無効)
if vim.env.DISPLAY or vim.env.WAYLAND_DISPLAY or vim.fn.has "mac" == 1 then
  vim.opt.clipboard = "unnamedplus"
else
  local osc52 = require("vim.ui.clipboard.osc52")
  local cache = { ["+"] = {}, ["*"] = {} }
  vim.g.clipboard = {
    name = "OSC 52 (copy only)",
    copy = {
      ["+"] = function(lines) cache["+"] = lines; osc52.copy("+")(lines) end,
      ["*"] = function(lines) cache["*"] = lines; osc52.copy("*")(lines) end,
    },
    paste = {
      ["+"] = function() return cache["+"] end,
      ["*"] = function() return cache["*"] end,
    },
  }
  vim.opt.clipboard = "unnamedplus"
end
