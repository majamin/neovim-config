local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local augroup = vim.api.nvim_create_augroup("Format", { clear = true })

null_ls.setup({
  sources = {
    null_ls.builtins.formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
    null_ls.builtins.diagnostics.eslint,
    null_ls.builtins.formatting.terraform_fmt,
    null_ls.builtins.formatting.black,
    null_ls.builtins.formatting.goimports,
    null_ls.builtins.formatting.gofumpt,
    null_ls.builtins.formatting.latexindent.with({
      extra_args = { "-g", "/dev/null" }, -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
    }),
    null_ls.builtins.code_actions.shellcheck,
    null_ls.builtins.diagnostics.vale,
  },
  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format()
        end,
      })
    end
  end,
})
