-- The Simpleman's Neovim Config --

local opts = require("opts")
require("boot") -- bootstraps lazy
require("auto") -- nice autocommands
require("opts") -- loads options, colors, etc.

require("lazy").setup({
  spec = {
    { import = "plug" },
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

-- Load LSP specs from lsp/
local contents = vim.uv.fs_scandir(vim.fn.stdpath("config") .. "/lsp")
while contents do
  local f = select(1, vim.uv.fs_scandir_next(contents))
  if f == nil then
    break
  end
  vim.lsp.enable(f:sub(1, -5))
end

vim.cmd("colorscheme github_light")
