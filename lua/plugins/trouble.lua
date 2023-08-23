local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  event = "VeryLazy",
}

M.config = function()
  local wk = require("which-key")

  wk.register({
    name = "Trouble",
    t = { "<cmd>TroubleToggle<cr>", "Navigate diagnostics" },
    -- T = { "<cmd>TodoTrouble<cr>", "Navigate todos" },
    -- ["xw"] = { "<cmd>TroubleToggle workspace_diagnostics<cr>", "" },
    -- ["xd"] = { "<cmd>TroubleToggle document_diagnostics<cr>", "" },
    -- ["xl"] = { "<cmd>TroubleToggle loclist<cr>", "" },
    -- ["xq"] = { "<cmd>TroubleToggle quickfix<cr>", "" },
  }, { prefix = ";" })
end

return M
