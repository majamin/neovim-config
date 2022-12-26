local theme = require("user").colorscheme

local M = {
  "jesseleite/nvim-noirbuddy",
  dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
  enabled = (theme == "noirbuddy"),
}

function M.config()
  require("noirbuddy").setup({
    styles = {
      italic = true,
      bold = false,
      underline = false,
      undercurl = true,
    },
  })
end

return M
