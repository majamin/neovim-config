local M = {}

M.keymap = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

-- Logic to handle colorscheme variants
M.get_colorscheme = function()
  local opts = require("user.opts")
  local colorscheme = opts.colorscheme_if_dark
  local path = vim.env.HOME .. "/.config/zsh/set-light-theme"
  if vim.fn.filereadable(path) == 1 then
    colorscheme = opts.colorscheme_if_light
  end
  return colorscheme
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
  vim.cmd("colorscheme " .. colorscheme)
end

return M
