local M = {
  "neovim/nvim-lspconfig",
}

M.dependencies = {
  { "williamboman/mason.nvim", opt = {} }, -- NOTE: Must be loaded before dependants
  { "williamboman/mason-lspconfig.nvim" },
  { "WhoIsSethDaniel/mason-tool-installer.nvim" },
  { "folke/lazydev.nvim", ft = "lua" },
}

M.config = function()
  local callback = require("user.funs").lsp_callback

  -- LSP settings (for overriding per client)
  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }
    ),
    ["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }
    ),
  }

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
    callback = callback,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )

  local servers = require("user.opts").servers
  local ensure_installed = vim.tbl_keys(servers or {})
  local formatters =
    require("user.funs").list_formatters(require("user.opts").formatters_by_ft)
  vim.list_extend(ensure_installed, formatters)
  require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

  require("mason").setup()
  require("mason-lspconfig").setup({
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend(
          "force",
          {},
          capabilities,
          server.capabilities or {}
        )
        server.handlers =
          vim.tbl_deep_extend("force", {}, handlers, server.handlers or {})
        require("lspconfig")[server_name].setup(server)
      end,
    },
  })

  -- Setup servers that are installed already, and only need setup
  local servers_setup_only = require("user.opts").servers_setup_only
  for _, server_name in ipairs(vim.tbl_keys(servers_setup_only)) do
    local server = servers_setup_only[server_name] or {}
    server.capabilities =
      vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
    server.handlers =
      vim.tbl_deep_extend("force", {}, handlers, server.handlers or {})
    require("lspconfig")[server_name].setup(server)
  end
end

return M
