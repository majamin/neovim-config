local M = {}

M.keymap = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

return M
