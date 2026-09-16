-- The Simpleman's Neovim Config --

require("boot") -- bootstraps lazy
require("funs") -- helper functions (fold text, etc.)
require("auto") -- nice autocommands
require("opts") -- loads options, colors, etc.

require("lazy").setup({
  spec = {
    { import = "plug" }, -- lua/plug.lua
  },
  change_detection = {
    enabled = false,
  },
  install = {
    missing = true,
    colorscheme = { "habamax" },
  },
})

-- Needs to load after lazy.setup(), which resets the runtimepath and would drop this package
vim.cmd.packadd("nvim.undotree")

require("lsps") -- LSP attach behaviour and servers from lsp/
