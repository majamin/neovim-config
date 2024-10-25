local M = {}

M.keymap = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

-- Safely set colorscheme
M.set_colorscheme = function(colorscheme)
  local colorscheme_fallback = require("user.opts").colorscheme_fallback
  ---@diagnostic disable-next-line
  local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not ok then
    vim.cmd("colorscheme " .. colorscheme_fallback)
    vim.print("Colorscheme not found: " .. colorscheme)
  end
end

return M
