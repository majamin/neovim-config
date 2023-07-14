local M = {}
local lsp_leader = "<C-l>" -- For some functions only - see below
local nmap = require("user/funs").nmap

M.autocmp = true

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

M.on_attach = function(client, bufnr)
  local filetype = vim.api.nvim_buf_get_option(0, "filetype")
  local format_code
  if client.supports_method("textDocument/formatting") then
    format_code = "<cmd>lua vim.lsp.buf.format()<CR>"
  elseif client.supports_method("textDocument/rangeFormatting") then
    format_code = "<cmd>lua vim.lsp.buf.range_formatting()<CR>"
  elseif vim.tbl_contains({ "go", "rust" }, filetype) then
    format_code = "<cmd>lua vim.lsp.buf.formatting_sync()<CR>"
  else
    format_code = "<cmd>Format<CR>"
  end

  nmap(lsp_leader .. "r", vim.lsp.buf.rename, bufnr, "[R]e[n]ame")
  nmap(lsp_leader .. "a", vim.lsp.buf.code_action, bufnr, "[C]ode [A]ction")
  nmap("gd", vim.lsp.buf.definition, bufnr, "[G]oto [D]efinition")
  nmap(
    "gr",
    require("telescope.builtin").lsp_references,
    bufnr,
    "[G]oto [R]eferences"
  )
  nmap("gI", vim.lsp.buf.implementation, bufnr, "[G]oto [I]mplementation")
  nmap(
    lsp_leader .. "D",
    vim.lsp.buf.type_definition,
    bufnr,
    "Type [D]efinition"
  )
  nmap(
    lsp_leader .. "ds",
    require("telescope.builtin").lsp_document_symbols,
    bufnr,
    "[D]ocument [S]ymbols"
  )
  nmap(
    lsp_leader .. "ws",
    require("telescope.builtin").lsp_dynamic_workspace_symbols,
    bufnr,
    "[W]orkspace [S]ymbols"
  )
  nmap("K", vim.lsp.buf.hover, bufnr, "Hover Documentation")
  nmap("gD", vim.lsp.buf.declaration, bufnr, "[G]oto [D]eclaration")

  -- Create a command `:Format` local to the LSP buffer
  nmap(lsp_leader .. "f", format_code, bufnr, "[F]ormat buffer")
end

return M
