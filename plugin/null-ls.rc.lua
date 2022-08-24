local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local formatting = null_ls.builtins.formatting

local sources = {
  formatting.prettierd,
  formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
  formatting.latexindent.with({
    extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
  }),
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Neovim ^0.8
local format = function(payload)
  vim.lsp.buf.format({
    filter = function(client)
      return client.name ~= "volar"
    end,
  })
end

null_ls.setup({
  debug = false,
  sources = sources,
  on_attach = function(client, bufnr)
    local all_clients = {}
    if client.server_capabilities.documentFormattingProvider then
      table.insert(all_clients, client)
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = format,
      })
    end
    print(all_clients)
  end,
})
