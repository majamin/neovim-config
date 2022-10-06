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
    a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
    d = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition" },
    o = { "<cmd>LSoutlineToggle<CR>", "Outline" },
    r = { "<cmd>Lspsaga rename<CR>", "Rename object" },
    s = { "<Cmd>Lspsaga signature_help<CR>", "Signature help" },
  }, { prefix = "<C-l>", mode = "n", opts = default_options })
  -- LSP no leader
  wk.register({
    name = "LSP - no leader",
    gd = { "<cmd>Lspsaga lsp_finder<CR>", "Explore definitions" },
    K = { "<cmd>Lspsaga hover_doc<CR>", "View doc for symbol" },
    ["<C-j>"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic" },
    ["<C-k>"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Previous diagnostic" },
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
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
        workspace = {
          -- Make the server aware of Neovim runtime files
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
