-- Non-plugin based keymaps

vim.keymap.set("n", "x", '"_x')

-- Increment/decrement
vim.keymap.set("n", "+", "<C-a>")
vim.keymap.set("n", "-", "<C-x>")

-- Browse buffers
vim.keymap.set("n", "<Tab>", ":bnext<CR>")
vim.keymap.set("n", "<S-Tab>", ":bprev<CR>")

-- Move window
vim.keymap.set("", "<C-h>", "<C-w>h")
vim.keymap.set("", "<C-k>", "<C-w>k")
vim.keymap.set("", "<C-j>", "<C-w>j")
vim.keymap.set("", "<C-l>", "<C-w>l")

-- Resize window
vim.keymap.set("n", "<left>", "<C-w><")
vim.keymap.set("n", "<right>", "<C-w>>")
vim.keymap.set("n", "<up>", "<C-w>+")
vim.keymap.set("n", "<down>", "<C-w>-")

vim.keymap.set("n", "<ESC>", ":noh<CR>")

vim.keymap.set("n", "<F3>", ":setlocal spell! spelllang=en_ca<CR>")
vim.keymap.set("n", "<F4>", ":setlocal spell! spelllang=en-basic<CR>")

vim.keymap.set("n", "<C-b>", ":bp|bd #<CR>")
vim.keymap.set("n", "<C-q>", "<C-w>q")

vim.keymap.set("t", "<ESC><ESC>", "<C-\\><C-n>")
