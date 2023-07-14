local M = {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
}

M.config = true

M.keys = {
  { ";t", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true } },
  { ";T", "<cmd>TodoTrouble<cr>", { silent = true, noremap = true } },
  --vim.keymap.set("n", ";xw", "<cmd>TroubleToggle workspace_diagnostics<cr>", {silent = true, noremap = true})
  --vim.keymap.set("n", ";xd", "<cmd>TroubleToggle document_diagnostics<cr>", {silent = true, noremap = true})
  --vim.keymap.set("n", ";xl", "<cmd>TroubleToggle loclist<cr>", {silent = true, noremap = true})
  --vim.keymap.set("n", ";xq", "<cmd>TroubleToggle quickfix<cr>", {silent = true, noremap = true})
  vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", {silent = true, noremap = true})
}

return M
