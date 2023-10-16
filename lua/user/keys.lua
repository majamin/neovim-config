-- NOTE: plugin specific maps contained in each plugin file lua/plugins/*

local M = {}
local opts = { silent = true }

-- Improvements to defaults
vim.keymap.set({ "n" }, "x", '"_x') -- send single chars to blackhole
vim.keymap.set({ "n" }, "<ESC>", ":noh<CR>", opts) -- turn off search hi
vim.keymap.set({ "v" }, "<", "<gv", opts) -- keep selection after outdent
vim.keymap.set({ "v" }, ">", ">gv", opts) -- keep selection after indent

-- Nice-to-haves
vim.keymap.set({ "n" }, "<BS>", "<C-^>", opts)
vim.keymap.set({ "n" }, "<TAB>", ":bn<CR>", opts)
vim.keymap.set({ "n" }, "<S-TAB>", ":bp<CR>", opts)
vim.keymap.set({ "n" }, "<C-w>b", ":Bdelete<CR>", opts)
vim.keymap.set({ "n" }, "<F3>", ":setlocal spell!<CR>", opts)

-- Find images, mark them with 'm', paste paths to file
vim.keymap.set(
  { "n" },
  "<leader>i",
  ":r !find . -maxdepth 3 -print | file -if - | grep \"image/\" | cut -d':' -f1 | xargs sxiv -qto <CR><CR>",
  opts
)

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

vim.keymap.set(
  { "n" },
  "<leader>c",
  ':w! | !compiler "%:p"<CR>',
  opts -- { desc = "Run compiler on current file" }
)

vim.keymap.set(
  { "n" },
  "<F2>",
  function()
    vim.cmd(':wa|mksession!')
    vim.print("Session and files saved")
  end,
  opts -- { desc = "Make session and save files" }
)


-- OTHER USEFUL KEYMAPS

-- Copilot completion keymap
-- vim.cmd([[
--   imap <silent><script><expr> <C-J> copilot#Accept("\<CR>")
--   let g:copilot_no_tab_map = v:true
-- ]])

return M
