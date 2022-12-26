local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  local lualine = require("lualine")
  local theme = require("user").lualine_theme
  lualine.setup({
    options = {
      icons_enabled = false,
      theme = theme,
      component_separators = "",
      section_separators = "",
    },
  })
end

return M
