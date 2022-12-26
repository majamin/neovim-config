local M = {
  "folke/tokyonight.nvim",
}

function M.config()
  local tokyo = require("tokyonight")
  tokyo.setup({
    style = "storm", -- `storm`, `night`, `day`
    transparent = false,
    sidebars = { "qf", "help" }, -- filetype windows with darker background
    day_brightness = 0.3, -- only used if `day` is set
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
  })
end

function M.init()
  local theme = require("user").colorscheme
  if theme == "tokyonight" then vim.cmd("colorscheme " .. theme) end
end

return M

