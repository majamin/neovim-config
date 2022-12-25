local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  }
}

local function on_attach(client, _) -- (client, bunfr)
  -- disable formatting for LSP clients as this is handled by null-ls
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
end

function M.init()
  local nvim_lsp = require("lspconfig")

  -- Set up completion using nvim_cmp with LSP source
  local capabilities = require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

  -- Import requested servers
  local servers = require("user").lsp_servers

  -- Import override settings
  local overrides = require("user").overrides

  for _, lsp in ipairs(servers) do
    nvim_lsp[lsp].setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = overrides
    })
  end
end

return M
