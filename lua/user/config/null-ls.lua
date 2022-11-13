local status, null_ls = pcall(require, "null-ls")
if not status then
  return
end

local autofmt = require("user.user-conf").autofmt

local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

-- [[ READ THIS! ]]
-- https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTIN_CONFIG.md

local sources = {
  -- Python
  formatting.black,
  -- C, C++, C#, Java, Cuda
  formatting.clang_format,
  -- Latex
  -- https://github.com/cmhughes/latexindent.pl/releases/tag/V3.9.3
  formatting.latexindent.with({ extra_args = { "-g", "/dev/null" } }),
  -- HTML, JS, CSS
  formatting.prettierd,
  -- Lua
  formatting.stylua.with({ extra_args = { "--indent-type", "Spaces", "--indent-width", "2" } }),
  -- Shell (bash, etc.)
  formatting.shfmt,
  -- Git code actions
  code_actions.gitsigns,
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
          if autofmt then
            vim.lsp.buf.format({ bufnr = bufnr })
          end
        end,
      })
    end
  end,
})
