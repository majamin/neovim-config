-- ~~ The Simpleman's Neovim Config ~~
-- .
-- ├── init.lua                   -- This file
-- ├── ...
-- └── lua
--     ├── plugins                -- Put your plugins in here!
--     │   ├── init.lua           -- Loads plugins with simple specs
--     │   ├── oil.lua            -- Larger plugins have their own files
--     │   └── ...
--     └── user
--         ├── init.lua           -- The only file you should have to edit
--         ├── lazy.lua
--         ├── maps.lua
--         └── opts.lua

-- NOTE: go here first -> user/init.lua

-- Run :W to see a list of keymaps
-- Run :Mason to see installed LSPs, formatters, etc.
-- Run :Lazy to open the package manager

-- HELPFUL BOOKMARKS
-- https://lazy.folke.io/spec
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

local user = require("user")
require("user.lazy") -- bootstraps lazy
require("user.auto") -- nice autocommands
require("user.opts") -- loads options, colors, etc.

vim.g.mapleader = user.mapleader
vim.g.maplocalleader = user.maplocalleader

-- Plugins
require("lazy").setup({
  spec = {
    { import = "plugins" }, -- loads all plugins in lua/plugins
    { import = "user.keys" }, -- uses WhichKey, your keymaps
  },
  change_detection = {
    -- automatically check for config file changes and reload the ui
    enabled = false,
    notify = true, -- get a notification when changes are found
  },
})

-- Attempt to load the colorscheme using pcall.
-- If it fails, fall back to slate.
local colorscheme = user.colorscheme
local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not ok then
  vim.cmd("colorscheme slate")
  vim.print("Colorscheme not found: " .. colorscheme)
end
