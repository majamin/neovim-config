local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local formatting = null_ls.builtins.formatting

local sources = {
  formatting.prettierd, -- Don't forget to add your prettierrc to your project!
  formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
  formatting.shfmt,
  formatting.latexindent.with({
    extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
  }),
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
  debug = false,
  sources = sources,
  on_attach = function(client, bufnr)
    if client.server_capabilities.documentFormattingProvider then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format({ bufnr = bufnr })
        end,
      })
    end
  end,
})
