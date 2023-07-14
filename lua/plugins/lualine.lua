local M = {
  "nvim-lualine/lualine.nvim",
}

function M.config()
  local lualine = require("lualine")
  local theme = require("user").lualine_theme
  lualine.setup({
    options = {
      icons_enabled = true,
      theme = theme,
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
      lualine_x = {
        {
          require("lazy.status").updates,
          cond = require("lazy.status").has_updates,
          color = { fg = "#ff9e64" },
        },
        "encoding",
        { "fileformat", icons_enabled = false },
      },
      lualine_y = {
        { "filetype", icons_enabled = false },
      },
      lualine_z = { "progress", "location" },
    },
  })
end

return M
