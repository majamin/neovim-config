--[[ START HERE ]]
local M = {}

-- Guests and VSCode addicts
M.whichkey = false -- show key completion hints (`;k` to see all keymaps)
M.autocmp = false -- auto completions? (C-n for manual cmp)

-- M.lang = "en_us" -- US English
M.lang = "en_ca" -- Canadian English
M.colorscheme = "tokyonight"
M.lualine_theme = "auto" -- can be `tokyonight`, `onedark`

-- These servers will be installed and setup with defaults
-- Defaults can be overridden in `lua/user/config/lspconfig.lua`
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
M.servers = {
  "sumneko_lua",
  "tsserver",
  "cssls",
  "volar",
  "tailwindcss",
  "pyright",
  "rust_analyzer",
}

return M
