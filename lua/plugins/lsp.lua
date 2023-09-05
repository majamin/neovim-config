local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", tag = "legacy", opts = {} },
    { "folke/neodev.nvim", config = true },
  },
  event = "VeryLazy",
  -- dependencies = "cmp",
}

local contains = require("user/funs").contains

M.config = function()
  local formatters = {}
  -- local capabilities = require("cmp_nvim_lsp").default_capabilities(
  --   vim.lsp.protocol.make_client_capabilities()
  -- )
  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")
  local mason_will_install = {}
  local user_lsp_data = require("user").dev
  local mason_ignore = require("user").mason_ignore

  -- Turn off inline diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"] =
    vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false,
    })

  -- check to see if a server is in the dont_install list
  for server_name, _ in pairs(user_lsp_data) do
    if not contains(mason_ignore, server_name) then
      table.insert(mason_will_install, server_name)
    end
  end

  mason_lspconfig.setup({
    ensure_installed = mason_will_install,
    automatic_installation = { exclude = mason_ignore },
  })

  local settings = {}
  for server_name, data in pairs(user_lsp_data) do
    settings[server_name] = data.settings
    table.insert(formatters, data.formatter)
  end

  for _, formatter in pairs(formatters) do
    if
      not contains(
        require("mason-registry").get_installed_package_names(),
        formatter
      )
    then
      vim.cmd("MasonInstall " .. formatter)
    end
  end

  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = require("user/funs").on_attach,
        settings = settings,
      })
    end,
  })

  for _, server in ipairs(mason_ignore) do
    if lspconfig[server] then
      lspconfig[server].setup({
        capabilities = capabilities,
        on_attach = require("user/funs").on_attach,
        settings = settings[server],
      })
    end
  end
end

return M
