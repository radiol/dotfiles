-- This will run last in the setup process.
-- This is just pure lua so anything that doesn't
-- fit in the normal config locations above can go here

-- copy/paste system clipboard to OS clipboard
-- X/Wayland環境またはmacOSではシステムクリップボード、なければOSC 52
-- OSC 52はターミナルエミュレータが対応している必要がある
if vim.env.DISPLAY or vim.env.WAYLAND_DISPLAY or vim.fn.has "mac" == 1 then
  vim.opt.clipboard = "unnamedplus"
else
  vim.g.clipboard = {
    name = "OSC 52",
    copy = {
      ["+"] = require("vim.ui.clipboard.osc52").copy "+",
      ["*"] = require("vim.ui.clipboard.osc52").copy "*",
    },
    paste = {
      ["+"] = require("vim.ui.clipboard.osc52").paste "+",
      ["*"] = require("vim.ui.clipboard.osc52").paste "*",
    },
  }
  vim.opt.clipboard = "unnamedplus"
end
