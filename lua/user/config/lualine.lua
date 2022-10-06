local status, lualine = pcall(require, "lualine")
if not status then
  return
end

local theme = require("user.user-conf").lualine_theme

lualine.setup({
  options = {
    icons_enabled = false,
    theme = theme,
    component_separators = "",
    section_separators = "",
  },
})
