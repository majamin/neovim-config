-- ~~ The Simpleman's Neovim Config ~~
-- .
-- ├── init.lua                   -- This file
-- ├── ...
-- └── lua/
--     ├── plugins/               -- Put your plugins in here!
--     │   ├── colorscheme.lua    -- Good example of a multispec plugin file
--     │   ├── completion.lua     -- Good example of a single spec plugin file
--     │   └── ...
--     └── user/
--         ├── auto.lua
--         ├── boot.lua
--         ├── funs.lua
--         ├── keys.lua
--         ├── opts.lua           -- TODO: go here first!
--         └── ...

-- HELPFUL BOOKMARKS
-- https://lazy.folke.io/spec
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

-- WARN: Don't edit anything past this point unless you know what you're doing

local opts = require("user.opts")
require("user.boot") -- bootstraps lazy
require("user.auto") -- nice autocommands
require("user.opts") -- loads options, colors, etc.

vim.g.mapleader = opts.mapleader
vim.g.maplocalleader = opts.maplocalleader

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
