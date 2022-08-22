local theme = require("majamin.user-conf").theme

local ok, _ = pcall(vim.cmd, "colorscheme " .. theme)
if not ok then
  vim.cmd("colorscheme slate")
end

vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.winblend = 0
vim.opt.wildoptions = "pum"
vim.opt.pumblend = 5
vim.opt.background = "dark"

vim.cmd("hi NonText guifg=#444466")
