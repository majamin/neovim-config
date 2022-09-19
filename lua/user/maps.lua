-- Non-plugin based keymaps
local opts = { silent = true }
local expr_opts = { silent = true, expr = true }
vim.keymap.set("n", "x", '"_x')

-- Remap for dealing with visual line wraps
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- Alternate buffer
vim.keymap.set("x", "<TAB>", "<cmd>e#<cr>", opts, { desc = "Jump to last buffer" })

-- better indenting
vim.keymap.set("v", "<", "<gv", opts, { desc = "Indent lines out" })
vim.keymap.set("v", ">", ">gv", opts, { desc = "Indent lines in" })

-- Move window
-- vim.keymap.set("", "<C-h>", "<C-w>h", opts, { desc = "Go to window on the left" })
-- vim.keymap.set("", "<C-k>", "<C-w>k", opts)
-- vim.keymap.set("", "<C-j>", "<C-w>j", opts)
-- vim.keymap.set("", "<C-l>", "<C-w>l", opts)

vim.keymap.set("n", "<ESC>", ":noh<CR>", opts, { desc = "Search highlight off" })

vim.keymap.set("n", "<F3>", ":setlocal spell!<CR>", opts, { desc = "Toggle spelling" })
vim.keymap.set("n", "<F4>", ":setlocal spell! spelllang=en-basic<CR>", opts, { desc = "Toggle basic English spelling" })

-- to mimic <C-w>q for window
vim.keymap.set("n", "<C-w>b", ":bp|bd! #<CR>", opts, { desc = "Kill buffer" })

-- paste from the yank register
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste from yank register" })

vim.keymap.set({ "n", "v" }, "<space>", "<Nop>", { silent = true })
