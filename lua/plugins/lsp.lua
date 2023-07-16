local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim",       tag = "legacy", opts = {} },
    { "folke/neodev.nvim",       config = true },
  },
}

local emmet_filetypes = {
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

local servers = {}
local user_wants_dev = require("user").dev

if user_wants_dev["javascript"] ~= nil then
  servers["tsserver"] = {}
end

if user_wants_dev["web"] ~= nil then
  servers["tsserver"] = {}
  servers["emmet_ls"] = {
      filetypes = emmet_filetypes,
      init_options = {
        html = {
          options = {
            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ["bem.enabled"] = true,
            ["jsx.enabled"] = true,
          },
        },
      },
  }
  servers["cssls"] = {}
  servers["tailwindcss"] = {}
end

if user_wants_dev["rust"] ~= nil then
  servers["rust_analyzer"] = {}
end

if user_wants_dev["go"] ~= nil then
  servers["gopls"] = {}
end

if user_wants_dev["c"] ~= nil then
  servers["clangd"] = {}
end

if user_wants_dev["lua"] ~= nil then
  servers["lua_ls"] = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }
end

M.config = function()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

  local lspconfig = require("lspconfig")
  local mason_lspconfig = require("mason-lspconfig")

  -- Turn off inline diagnostics
  vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
      virtual_text = false
    }
  )

  mason_lspconfig.setup({
    ensure_installed = vim.tbl_keys(servers),
  })

  mason_lspconfig.setup_handlers({
    function(server_name)
      require("lspconfig")[server_name].setup({
        capabilities = capabilities,
        on_attach = require("user/funs").on_attach,
        settings = servers[server_name],
      })
    end,
  })
end

return M
