local M = {
  "folke/which-key.nvim",
  enabled = require("user").whichkey,
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 300
  end,
}

function M.config()
  local wk = require("which-key")

  wk.setup({
    layout = {
      height = { min = 4, max = 25 }, -- min and max height of the columns
      width = { min = 20, max = 50 }, -- min and max width of the columns
      spacing = 2,                    -- spacing between columns
      align = "center",               -- align columns left, center or right
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

  wk.register(require("user.keys").local_maps)

end

return M
