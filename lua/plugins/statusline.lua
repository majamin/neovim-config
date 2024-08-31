local M = {
  "nvim-lualine/lualine.nvim", -- https://github.com/nvim-lualine/lualine.nvim
  event = "VeryLazy",
}

function M.config()
  local lualine = require("lualine")
  local lazy_status = require("lazy.status")
  lualine.setup({
    options = {
      icons_enabled = true,
      component_separators = { left = "", right = "" },
    },
    sections = {
      lualine_b = { { "branch", icon = "" }, "diff", "diagnostics" },
      lualine_c = { "filename" },
      lualine_x = {
        {
          lazy_status.updates,
          cond = lazy_status.has_updates,
        },
        { "encoding" },
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
