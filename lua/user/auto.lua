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

-- Go to last location when opening a buffer
vim.api.nvim_create_autocmd("BufReadPost", {
  command = [[if line("'\"") > 1 && line("'\"") <= line("$") | execute "normal! g`\"" | endif]],
})

-- Turn off paste mode when leaving insert
vim.api.nvim_create_autocmd("InsertLeave", {
  pattern = "*",
  command = "set nopaste",
})

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group =
  vim.api.nvim_create_augroup("YankHighlight", { clear = true })

vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({ higroup = "Constant", timeout = 400 })
  end,
  group = highlight_group,
  pattern = "*",
})

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
