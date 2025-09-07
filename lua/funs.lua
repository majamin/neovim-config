local M = {}

-- Folding aesthetic
function _G.myfolds()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return line .. " ·········· " .. line_count .. " lines "
end

-- Do we have a filetype window open?
function M.have_window_by_filetype(name)
  for _, win in ipairs(vim.api.nvim_list_wins()) do
    local bufnr = vim.api.nvim_win_get_buf(win)
    if vim.bo[bufnr].filetype == name then
      return true
    end
  end
  return false
end

return M
