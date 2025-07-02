-- The Simpleman's Neovim Config --

local opts = require("opts")
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
