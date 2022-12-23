local status, nvim_lsp = pcall(require, "lspconfig")
if not status then
  return
end

local function on_attach(client, _) -- (client, bunfr)
  -- disable formatting for LSP clients as this is handled by null-ls
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false
  -- stylua: ignore start
  vim.keymap.set("n", "<C-l>a", "<cmd>lua vim.lsp.buf.code_action()<CR>",     { desc = "Code action"          })
  vim.keymap.set("n", "<C-l>r", "<cmd>lua vim.lsp.buf.rename()<CR>",          { desc = "Rename symbol"        })
  vim.keymap.set("n", "<C-l>i", "<cmd>lua vim.lsp.buf.implementation()<CR>",  { desc = "Show implementations" })
  vim.keymap.set("n", "<C-l>t", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { desc = "Type definition"      })
  vim.keymap.set("n", "<C-l>f", "<cmd>lua vim.lsp.buf.format()<CR>",          { desc = "Format the buffer"    })
  vim.keymap.set("n", "gd",     "<cmd>lua vim.lsp.buf.definition()<CR>",      { desc = "Go to definition"     })
  vim.keymap.set("n", "gD",     "<cmd>lua vim.lsp.buf.declaration()<CR>",     { desc = "Go to declaration"    })
  vim.keymap.set("n", "K",      "<cmd>lua vim.lsp.buf.hover()<CR>",           { desc = "View doc for symbol"  })
  vim.keymap.set("n", "<C-j>",  "<cmd>lua vim.diagnostic.goto_next()<CR>",    { desc = "Next Diagnostic"      })
  vim.keymap.set("n", "<C-k>",  "<cmd>lua vim.diagnostic.goto_prev()<CR>",    { desc = "Prev Diagnostic"      })
  -- stylua: ignore stop
end

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
