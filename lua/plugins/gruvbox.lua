local M = {
  "ellisonleao/gruvbox.nvim",
}

local user = require("user")

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
    transparent_mode = user.bg_is_transparent,
  })
end

function M.init()
  local colorscheme = require("user").colorscheme
  if colorscheme == "gruvbox" then
    vim.cmd("colorscheme " .. colorscheme)
  end
end

return M
