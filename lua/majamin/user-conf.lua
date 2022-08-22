local M = {}

-- M.lang = "en_us" -- US English
M.lang = "en_ca" -- Canadian English

-- theme: photon (a minimal colorscheme)
M.theme = "slate"

-- These servers will be installed automatically
-- You can still install servers via `:Mason`
-- Configuration of servers happens in `plugin/lspconfig.lua` (but most don't require this)
M.servers = {
  "sumneko_lua",
  "tsserver",
  "volar",
  "tailwindcss",
  "pyright",
}

return M
