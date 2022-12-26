local M = {
  "jesseleite/nvim-noirbuddy",
  dependencies = { "tjdevries/colorbuddy.nvim", branch = "dev" },
}

function M.config()
  if require("user").colorscheme == "miami-nights" then
    require("noirbuddy").setup({
      preset = "miami-nights"
    })
  else
    return {}
  end

end

return M
