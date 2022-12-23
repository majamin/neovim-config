local status_ok, gruvbox = pcall(require, "gruvbox")
if not status_ok then
  return
end

gruvbox.setup({
  undercurl = true,
  underline = true,
  bold = true,
  italic = true,
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "soft", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})

local theme = require("user").colorscheme
if theme == "gruvbox" then vim.cmd("colorscheme " .. theme) end
