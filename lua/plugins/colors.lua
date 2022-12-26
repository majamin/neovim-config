local M = {
  "jesseleite/nvim-noirbuddy",
  dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
}

function M.config()
  require("noirbuddy").setup({
    preset = "miami-nights"
  })
end

return M
