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
  callback = function(ev)
    vim.api.nvim_set_option_value("wrap", true, { scope = "local" })
  end,
})
