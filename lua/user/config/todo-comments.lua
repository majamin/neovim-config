local status_ok, todo = pcall(require, "todo-comments")
if not status_ok then
  return
end

todo.setup({})

vim.keymap.set("n", ";t", "<Cmd>TodoTelescope<CR>", { desc = "Find TODOs, ERRORs, etc." })

-- EXAMPLE Specify a list of valid jump keywords
-- vim.keymap.set("n", "]t", function()
--   require("todo-comments").jump_next({keywords = { "ERROR", "WARNING" }})
-- end, { desc = "Next error/warning todo comment" })
