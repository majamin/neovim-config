local M = {}

-- Use git files or fallback to normal find_files
M.project_files = function()
  if not pcall(require, "telescope.builtin") then
    print("Telescope.builtin not accessible")
    return
  end
  local opts = {} -- define here if you want to define something
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

-- Waiting for an API, like https://github.com/neovim/neovim/pull/19238
M.abbrev = function(l, r)
  vim.cmd({ cmd = "abbrev", args = { l, r } })
end

M.on_attach = function(client, bufnr)
  local wk = require("which-key")

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

  wk.register({
    name = "LSP actions",
    r = { vim.lsp.buf.rename, "[r]ename object" },
    a = { vim.lsp.buf.code_action, "code [a]ctions" },
    D = { vim.lsp.buf.declaration, "go to [d]eclaration" },
    t = { vim.lsp.buf.type_definition, "go to [t]ype definition" },
    f = { format_code, "[f]ormat the buffer" },
    s = {
      require("telescope.builtin").lsp_document_symbols,
      "document [s]ymbols",
    },
    w = {
      require("telescope.builtin").lsp_dynamic_workspace_symbols,
      "[w]orkspace symbols",
    },
  }, { prefix = "gl", buffer = bufnr })

  wk.register({
    d = { vim.lsp.buf.definition, "go to [d]efinition" },
    r = { require("telescope.builtin").lsp_references, "go to [r]eferences" },
    I = { vim.lsp.buf.implementation, "go to [i]mplementation" },
  }, { prefix = "g", buffer = bufnr })

  wk.register({
    K = { vim.lsp.buf.hover, "hover documentation" },
    ["<C-j>"] = {
      "<cmd>lua vim.diagnostic.goto_next()<CR>",
      "go to next diagnostic",
    },
    ["<C-k>"] = {
      "<cmd>lua vim.diagnostic.goto_previous<CR>",
      "go to previous diagnostic",
    },
  }, { buffer = bufnr })
end

return M
