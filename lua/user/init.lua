local M = {}

M.autocmp = true

M.whichkey = true

M.colorscheme = "tokyonight"

M.servers = {
  clangd = {},
  pyright = {},
  rust_analyzer = {},
  tsserver = {},
  lua_ls = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
}

M.emmet_filetypes = {
  "css",
  "eruby",
  "html",
  "javascript",
  "javascriptreact",
  "less",
  "sass",
  "scss",
  "svelte",
  "pug",
  "typescriptreact",
  "vue",
}

return M
