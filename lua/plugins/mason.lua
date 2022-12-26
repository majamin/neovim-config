local M = {
  "williamboman/mason.nvim",
  dependencies = {
    "williamboman/mason-lspconfig.nvim",
  },
  cmd = { "Mason" },
  lazy = true,
}

function M.config()
  local mason = require("mason")
  local mason_config = require("mason-lspconfig")
  local servers = require("user").lsp_servers

  mason.setup({})
  mason_config.setup({
    automatic_installation = true,
    ensure_installed = servers,
  })
end

return M
