-- NOTE: plugin specific maps contained in each plugin file lua/plugins/*

local M = {}
local opts = { silent = true }
local expr_opts = { silent = true, expr = true }

-- Sanity
M.local_maps = {
  x = { '"_x', "Remapped x - send char to blackhole register" },
  -- vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', opts, { desc = "Paste from yank register" })
  ["<ESC>"] = { ":noh<CR>", "" },
  ["<"] = { "<gv", "Indent lines out" },
  [">"] = { ">gv", "Indent lines in" },
  ["<BS>"] = { "<C-^>", "Jump to alternate buffer" },
  ["<TAB>"] = { ":bn<CR>", "Go to next buffer" },
  ["<S-TAB>"] = { ":bp<CR>", "Go to previous buffer" },
  ["<C-w>b"] = { ":Bdelete<CR>", "Kill buffer" },
  ["<F3>"] = { ":setlocal spell!<CR>", "Toggle spelling" },
  ["<leader>i"] = {
    ":r !find . -maxdepth 3 -print | file -if - | grep \"image/\" | cut -d':' -f1 | xargs sxiv -qto <CR><CR>",
    "Find images in current working directory using sxiv" }
}

-- ["k"] = { "v:count == 0 ? 'gk' : 'k'", expr_opts)
-- ["j"] = {} "v:count == 0 ? 'gj' : 'j'", expr_opts)
-- }

-- Yank and paste to tmux clipboard
vim.keymap.set(
  "v",
  "<leader><leader>y",
  'y<cr>:call system("tmux load-buffer -", @0)<cr>gv',
  opts,
  { desc = "Yank to the tmux clipboard" }
)
vim.keymap.set(
  "n",
  "<leader><leader>p",
  ':let @0 = system("tmux save-buffer -")<cr>"0p<cr>g;',
  opts,
  { desc = "Paste from the tmux clipboard" }
)

return M
