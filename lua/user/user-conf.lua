local M = {}

-- M.lang = "en_us" -- US English
M.lang = "en_ca" -- Canadian English
M.colorscheme = "tokyonight-storm"
M.lualine_theme = "auto" -- or 'tokyonight', 'onedark'

-- Servers will not configure unless they are listed here
-- LSP Defaults are usually good. Add server customization in `plugin/lspconfig.lua`
-- Defaults: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
M.servers = {
  "sumneko_lua",
  "tsserver",
  "cssls",
  "volar",
  "tailwindcss",
  "pyright",
  "r_language_server",
}

return M
