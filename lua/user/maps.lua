local opts = { silent = true }
local expr_opts = { silent = true, expr = true }

-- Sanity
vim.keymap.set({ "n", "v" }, "<space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<ESC>", ":noh<CR>", opts, { desc = "Search highlight off" })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
vim.keymap.set("n", "x", '"_x')
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p', { desc = "Paste from yank register" })
vim.keymap.set("v", "<", "<gv", opts, { desc = "Indent lines out" })
vim.keymap.set("v", ">", ">gv", opts, { desc = "Indent lines in" })

-- If we want C-l to be LSP we need this
-- vim.keymap.del("n", "<C-l>", opts)

-- Windows and buffers
vim.keymap.set("n", "<BS>", "<C-^>", opts, { desc = "Jump to alternate buffer" })
vim.keymap.set("n", "<C-w>b", ":Bdelete<CR>", opts, { desc = "Kill buffer" })

-- Spelling
vim.keymap.set("n", "<F3>", ":setlocal spell!<CR>", opts, { desc = "Toggle spelling" })
vim.keymap.set("n", "<F4>", ":setlocal spell! spelllang=en-basic<CR>", opts, { desc = "Toggle basic English spelling" })

-- [[ PLUGINS ]]

-- LSP keymaps attached here: ./lua/user/config/lspconfig.lua

-- Vimwiki
vim.keymap.set("n", "<S-F19>", "<Plug>VimwikiNextLink", opts, { desc = "Unnecessary Vimwiki binding" })
vim.keymap.set("n", "<S-F18>", "<Plug>VimwikiPrevLink", opts, { desc = "Unnecessary Vimwiki binding" })
vim.keymap.set("n", "<leader>w", "<Plug>VimwikiIndex", opts, { desc = "Open default Vimwiki" })

-- Harpoon
vim.keymap.set("n", "<C-h><C-h>", function()
  return require("harpoon.ui").toggle_quick_menu()
end, { desc = "Open harpoon" })
vim.keymap.set("n", "<C-h>a", function()
  return require("harpoon.mark").add_file()
end, { desc = "Add current file to harpoon" })
