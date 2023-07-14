local M = {
  "folke/which-key.nvim",
  enabled = require("user").whichkey,
}

function M.config()
  local wk = require("which-key")
  -- local options = { silent = true }

  wk.setup({
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 2, -- spacing between columns
      align = "center", -- align columns left, center or right
    },
    hidden = {
      "<silent>",
      "<Plug>",
      "<cmd>",
      "<Cmd>",
      "<cr>",
      "<CR>",
      "call",
      "lua",
      "require",
      "^:",
      "^ ",
    },
    disable = {
      buftypes = {},
      filetypes = { true },
    },
  })
end

return M
