local M = {
  "folke/todo-comments.nvim",
  dependencies = "nvim-lua/plenary.nvim",
}

function M.config()
  local todo = require("todo-comments")
  todo.setup({
    signs = false,
  })
end

function M.init()
  vim.keymap.set("n", ";t", "<Cmd>TodoTelescope<CR>", { desc = "Find TODOs, ERRORs, etc." })
  -- EXAMPLE Specify a list of valid jump keywords
  -- vim.keymap.set("n", "]t", function()
  --   require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
  -- end, { desc = "Next error/warning todo comment" })
end

return M
