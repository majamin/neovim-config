local M = {
  "mbbill/undotree",
}

M.config = function()
  vim.cmd([[let g:undotree_WindowLayout = 4]])
end

M.keys = {
  {
    "U",
    "<cmd>UndotreeToggle|UndotreeFocus<CR>",
    desc = "Open Undotree",
    { silent = true },
  },
}

return M
