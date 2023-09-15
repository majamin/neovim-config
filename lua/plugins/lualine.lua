local M = {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
}

function M.config()
  local lualine = require("lualine")
  local theme = require("user").lualine_theme
  local lazy_status = require("lazy.status")
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
          lazy_status.updates,
          cond = lazy_status.has_updates,
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
    extensions = { "fugitive" },
  })
end

return M
