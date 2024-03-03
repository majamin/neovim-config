local M = {
  "folke/todo-comments.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "folke/trouble.nvim",
  },
  event = "VeryLazy",
}

M.keys = {
  {";t", "<cmd>TroubleToggle<cr>", desc = "Navigate diagnostics" },
    -- T = { "<cmd>TodoTrouble<cr>", "Navigate todos" },
    -- ["xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "" },
    -- ["xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "" },
    -- ["xl"] = { "<cmd>TroubleToggle loclist<cr>", "" },
    -- ["xq"] = { "<cmd>TroubleToggle quickfix<cr>", "" },
  }

return M
