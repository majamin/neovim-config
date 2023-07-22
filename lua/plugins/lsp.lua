local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim",       tag = "legacy", opts = {} },
    { "folke/neodev.nvim",       config = true },
  },
}

local servers = {}
local formatters = {}
local emmet_filetypes = require("user/opts").emmet_filetypes
local user_wants_dev = require("user").dev
local contains = require("user/funs").contains

if contains(user_wants_dev, "python") then
  servers["pyright"] = {}
  if not contains(formatters, "black") then
    table.insert(formatters, "black")
  end
end

if contains(user_wants_dev, "javascript") then
  servers["tsserver"] = {}
  if not contains(formatters, "prettierd") then
    table.insert(formatters, "prettierd")
  end
end

if contains(user_wants_dev, "web") then
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
  if not contains(formatters, "prettierd") then
    table.insert(formatters, "prettierd")
  end
end

if contains(user_wants_dev, "rust") then
  servers["rust_analyzer"] = {}
end

if contains(user_wants_dev, "go") then
  servers["gopls"] = {}
end

if contains(user_wants_dev, "c") then
  servers["clangd"] = {}
  if not contains(formatters, "clang-format") then
    table.insert(formatters, "clang-format")
  end
end

if contains(user_wants_dev, "lua") then
  servers["lua_ls"] = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  }
  if not contains(formatters, "stylua") then
    table.insert(formatters, "stylua")
  end
end

if contains(user_wants_dev, "latex") then
  servers["texlab"] = {}
  if not contains(formatters, "latexindent") then
    table.insert(formatters, "latexindent")
  end
end

M.config = function()
  local capabilities = require("cmp_nvim_lsp").default_capabilities(
    vim.lsp.protocol.make_client_capabilities()
  )
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
    automatic_installation = true,
  })

  for _, formatter in pairs(formatters) do
    if not contains(require("mason-registry").get_installed_package_names(), formatter) then
      vim.cmd("MasonInstall " .. formatter)
    end
  end

  mason_lspconfig.setup_handlers({
    function(server_name)
      lspconfig[server_name].setup({
        capabilities = capabilities,
        on_attach = require("user/funs").on_attach,
        settings = servers[server_name],
      })
    end,
  })
end

return M
