-- Non-plugin based keymaps
local opts = { silent = true }
local expr_opts = { silent = true, expr = true }
vim.keymap.set("n", "x", '"_x')

--Remap for dealing with visual line wraps
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)

-- better indenting
vim.keymap.set("v", "<", "<gv", opts)
vim.keymap.set("v", ">", ">gv", opts)

-- Browse buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>", opts)
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>", opts)

-- Move window
vim.keymap.set("", "<C-h>", "<C-w>h", opts)
vim.keymap.set("", "<C-k>", "<C-w>k", opts)
vim.keymap.set("", "<C-j>", "<C-w>j", opts)
vim.keymap.set("", "<C-l>", "<C-w>l", opts)

-- Resize window
vim.keymap.set("n", "<left>", "<C-w><", opts)
vim.keymap.set("n", "<right>", "<C-w>>", opts)
vim.keymap.set("n", "<up>", "<C-w>+", opts)
vim.keymap.set("n", "<down>", "<C-w>-", opts)

vim.keymap.set("n", "<ESC>", ":noh<CR>", opts)

vim.keymap.set("n", "<F3>", ":setlocal spell! spelllang=en_ca<CR>", opts)
vim.keymap.set("n", "<F4>", ":setlocal spell! spelllang=en-basic<CR>", opts)

vim.keymap.set("n", "<C-w>b", ":bp|bd! #<CR>", opts)
vim.keymap.set("n", "<C-q>", "<C-w>q", opts)

vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>", opts)

-- paste from the yank register
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p')

vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
