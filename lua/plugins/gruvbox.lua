local M = {
  "ellisonleao/gruvbox.nvim",
}

function M.config()
  local gruvbox = require("gruvbox")

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
end

function M.init()
  local theme = require("user").colorscheme
  if theme == "gruvbox" then
    vim.cmd("colorscheme " .. theme)
  end
end

return M
