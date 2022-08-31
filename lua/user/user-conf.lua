local M = {}

-- M.lang = "en_us" -- US English
M.lang = "en_ca" -- Canadian English

-- Listing LSP servers here will install and setup defaults
-- Some further configuration may need to occur in `plugin/lspconfig.lua` (but most don't require this)
-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
M.servers = {
  "sumneko_lua",
  "tsserver",
  "volar",
  "tailwindcss",
  "pyright",
  "r_language_server",
  --"hls",
}

return M
