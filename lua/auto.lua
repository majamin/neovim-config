vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function() vim.hl.hl_op() end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "qf" },
  callback = function(args)
    vim.opt_local.wrap = true
    -- the global <CR> starts incremental selection, so restore the builtin jump to the entry
    vim.keymap.set("n", "<CR>", "<CR>", { buf = args.buf })
  end,
})

-- Set `>>` to `%>%` in R and Rmd files
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "r", "rmd" },
  callback = function(args)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.keymap.set("i", ">>", "%>%", { buf = args.buf })
      end
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
