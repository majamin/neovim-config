--vim.lsp.set_log_level("debug")

local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local function on_attach(client, _) -- (client, bunfr)
  -- disable formatting for LSP clients as this is handled by null-ls
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  local wk = require("which-key")
  local default_options = { silent = true }
  -- LSP <C-l>
  wk.register({
    name = "LSP",
    a = { "<cmd>lua vim.lsp.buf.code_action()<CR>", "Code action" },
    r = { "<cmd>lua vim.lsp.buf.rename()<CR>", "Rename symbol" },
    i = {
      "<cmd>lua vim.lsp.buf.implementation()<CR>",
      "Show implementations",
    },
    t = { "<cmd>lua vim.lsp.buf.type_definition()<CR>", "Type definition" },
    o = { "<cmd>LSoutlineToggle<CR>", "Outline" },
  }, { prefix = "<C-l>", mode = "n", opts = default_options })
  -- LSP no leader
  wk.register({
    name = "LSP - no leader",
    gd = { "<cmd>lua vim.lsp.buf.definition()<CR>", "Go to definition" },
    gD = { "<cmd>lua vim.lsp.buf.declaration()<CR>", "Go to declaration" },
    K = { "<cmd>lua vim.lsp.buf.hover()<CR>", "View doc for symbol" },
    ["<C-j>"] = { "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic" },
    ["<C-k>"] = { "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Prev Diagnostic" },
  })
end

-- Set up completion using nvim_cmp with LSP source
local capabilities = require("cmp_nvim_lsp").update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Import requested servers
local servers = require("user.user-conf").servers

--[[ SERVER CONFIGURATION ]]
-- Most servers have good defaults, so defining settings below is
-- not typically necessary (some do)
-- see: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      volar = {
        filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
      },
      tsserver = {
        filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
        cmd = { "typescript-language-server", "--stdio" },
      },
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          checkThirdParty = false,
        },
      },
      ["rust-analyzer"] = {
        imports = {
          granularity = {
            group = "module",
          },
          prefix = "self",
        },
        cargo = {
          buildScripts = {
            enable = true,
          },
        },
        procMacro = {
          enable = true,
        },
      },
    },
  })
end
