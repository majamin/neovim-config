local status_ok, tokyo = pcall(require, "tokyonight")
if not status_ok then
  return
end

tokyo.setup({
  style = "storm", -- `storm`, `night`, `day`
  transparent = false,
  sidebars = { "qf", "help" }, -- filetype windows with darker background
  day_brightness = 0.3, -- only used if `day` is set
  lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
})

local theme = require("user.user-conf").colorscheme
if theme == "tokyonight" then vim.cmd("colorscheme " .. theme) end
