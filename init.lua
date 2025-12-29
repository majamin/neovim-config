-- The Simpleman's Neovim Config --

require("boot") -- bootstraps lazy
require("auto") -- nice autocommands
require("opts") -- loads options, colors, etc.

require("lazy").setup({
  spec = {
    { import = "plug" }, -- lua/plug.lua
  },
  change_detection = {
    enabled = false,
    notify = true,
  },
  install = {
    missing = true,
    colorscheme = { "habamax" },
  },
})

vim.cmd("colorscheme github_light")
vim.api.nvim_set_hl(0, "DiagnosticHint", { fg = "#8799ab" })
vim.api.nvim_set_hl(0, "DiagnosticVirtualTextHint", { fg = "#8799ab" })

-- vim.cmd("colorscheme tokyonight")
