-- Remove trailing whitespace on save
local TrimWhiteSpaceGrp =
  vim.api.nvim_create_augroup("TrimWhiteSpaceGrp", { clear = true })
vim.api.nvim_create_autocmd("BufWritePre", {
  command = [[:%s/\s\+$//e]],
  group = TrimWhiteSpaceGrp,
})

-- Don't auto comment new line
vim.api.nvim_create_autocmd(
  "BufEnter",
  { command = [[set formatoptions-=cro]] }
)

-- Use `<ESC>` to conveniently close special windows
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "fugitive",
    "lspinfo",
    "man",
    "qf",
    "startuptime",
    "lazy",
    "checkhealth",
  },
  callback = function()
    vim.keymap.set(
      { "n" },
      "<ESC>",
      "<cmd>close<CR>",
      { silent = true, buffer = true }
    )
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
