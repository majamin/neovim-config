local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.init_lsp_saga()

local opts = { noremap = true, silent = true }

-- Lsp finder find the symbol definition implement reference
-- when you use action in finder like open vsplit then your can
-- use <C-t> to jump back
vim.keymap.set("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
-- vim.keymap.set("n", "gs", "<Cmd>Lspsaga signature_help<CR>", opts) -- NOT WORKING??
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set("n", "<C-y>", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "<C-e>", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)
vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
