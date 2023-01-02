local M = {
  "folke/tokyonight.nvim",
}

local user = require("user")
local colorscheme = require("user").colorscheme

function M.config()
  local tokyo = require("tokyonight")
  tokyo.setup({
    transparent = user.bg_is_transparent,
    sidebars = { "qf", "help", "harpoon", "TelescopePrompt" }, -- filetype windows with darker background
    day_brightness = 0.3, -- only used if `day` is set
    lualine_bold = true, -- When `true`, section headers in the lualine theme will be bold
  })
end

function M.init()
  if colorscheme == "tokyonight" or "tokyonight-day" or "tokyonight-night" or "tokyonight-moon" or "tokyonight-storm" then
    vim.cmd("colorscheme " .. colorscheme)
  end
end

return M
