local M = {}

-- Highlights
-- EOL, TAB, etc.
vim.cmd("hi NonText guifg=#444466")

-- M.lang = "en_us" -- US English
M.lang = "en_ca" -- Canadian English

-- Listing LSP servers here will install and setup defaults
-- Some further configuration may need to occur in `plugin/lspconfig.lua` (but most don't require this)
M.servers = {
  "sumneko_lua",
  "tsserver",
  "volar",
  "tailwindcss",
  "pyright",
  --"hls",
}

return M
