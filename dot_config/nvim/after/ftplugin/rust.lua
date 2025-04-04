local wk = require "which-key"

wk.add {
  { "<leader>r", group = "Rust" },
  { "<leader>rr", "<cmd>RustLsp run<CR>i", desc = "Run" },
  { "<leader>rn", "<cmd>RustLsp runnables<CR>", desc = "Runnables" },
  { "<leader>rt", "<cmd>RustLsp testables<CR>", desc = "Test" },
  { "<leader>rc", "<cmd>RustLsp openCargo<CR>", desc = "open Cargo" },
}
