local M = {}

-- Folding aesthetic
function _G.myfolds()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return line .. " ·········· " .. line_count .. " lines "
end

-- Is the location list of the current window open?
function M.loclist_is_open()
  return vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
end

return M
