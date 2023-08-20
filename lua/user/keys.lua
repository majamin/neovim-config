-- NOTE: plugin specific maps contained in each plugin file lua/plugins/*

local M = {}
local opts = { silent = true }

vim.keymap.set({ "n" }, "x", '"_x')
vim.keymap.set({ "n" }, "<ESC>", ":noh<CR>", opts)
vim.keymap.set({ "v" }, "<", "<gv", opts)
vim.keymap.set({ "v" }, ">", ">gv", opts)
vim.keymap.set({ "n" }, "<BS>", "<C-^>", opts)
vim.keymap.set({ "n" }, "<TAB>", ":bn<CR>", opts)
vim.keymap.set({ "n" }, "<S-TAB>", ":bp<CR>", opts)
vim.keymap.set({ "n" }, "<C-w>b", ":Bdelete<CR>", opts)
vim.keymap.set({ "n" }, "<F3>", ":setlocal spell!<CR>", opts)
vim.keymap.set(
  { "n" },
  "<leader>i",
  ":r !find . -maxdepth 3 -print | file -if - | grep \"image/\" | cut -d':' -f1 | xargs sxiv -qto <CR><CR>",
  opts
)

-- Yank and paste to tmux clipboard
vim.keymap.set(
  { "n", "v" },
  "<leader><leader>y",
  'y<cr>:call system("tmux load-buffer -", @0)<cr>gv',
  opts -- { desc = "Yank to the tmux clipboard" }
)
vim.keymap.set(
  { "n", "v" },
  "<leader><leader>p",
  ':let @0 = system("tmux save-buffer -")<cr>"0p<cr>g;',
  opts -- { desc = "Paste from the tmux clipboard" }
)

vim.cmd([[
imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
let g:copilot_no_tab_map = v:true
]])

return M
