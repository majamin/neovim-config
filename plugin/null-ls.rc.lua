local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local formatting = null_ls.builtins.formatting

local sources = {
  formatting.prettierd,
  formatting.stylua,
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
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = format,
      })
    end
  end,
})
