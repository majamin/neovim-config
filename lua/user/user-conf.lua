--[[ START HERE ]]
local M = {}

-- Guests and VSCode addicts
M.whichkey = false -- show key completion hints (`;k` to telescope all keymaps)
M.autocmp = false -- auto completions? (`C-n` for manual cmp)
M.autofmt = false -- autoformat on save? (`C-l f` to manually format)

-- M.lang = "en_us" -- US English
M.lang = "en_ca" -- Canadian English
M.colorscheme = "tokyonight"
M.lualine_theme = "auto" -- see 'https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md'

-- These servers will be installed and setup with defaults
M.servers = {
  "sumneko_lua",
  "tsserver",
  "cssls",
  "volar",
  "tailwindcss",
  "pyright",
  "rust_analyzer",
  "html",
}
-- Defaults can be overridden in `lua/user/config/lspconfig.lua`
-- See: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md

return M
