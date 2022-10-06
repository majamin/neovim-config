--[[ START HERE ]]
local M = {}

-- M.lang = "en_us" -- US English
M.lang = "en_ca" -- Canadian English
M.colorscheme = "tokyonight"
M.lualine_theme = "auto" -- can be `tokyonight`, `onedark`

-- Only servers listed here will be loaded
M.servers = {
  "sumneko_lua",
  "tsserver",
  "cssls",
  "volar",
  "tailwindcss",
  "pyright",
  "rust_analyzer",
}
-- No further action is required. Some servers require a few customizations.
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
-- `lua/user/config/lspconfig.lua` contains examples of how to do so
return M
