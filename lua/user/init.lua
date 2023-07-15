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

return M
