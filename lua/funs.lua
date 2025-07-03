local M = {}

-- Completion helpers
M.has_words_before = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col == 0 then
    return false
  end
  local line = vim.api.nvim_get_current_line()
  return line:sub(col, col):match("%s") == nil
end

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
    local ft = vim.api.nvim_get_option_value("filetype", { buf = bufnr })
    if ft == name then
      return true
    end
  end
  return false
end

return M
