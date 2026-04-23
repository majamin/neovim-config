vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.hl.on_yank() end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})

-- Set `>>` to `%>%` in R and Rmd files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "r", "rmd" },
  callback = function()
    vim.schedule(function()
      vim.keymap.set("i", ">>", "%>%", { buffer = true })
    end)
  end,
})

-- wrap in prose filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "markdown", "typst", "asciidoc" },
  callback = function()
    vim.opt_local.wrap = true
  end,
})
