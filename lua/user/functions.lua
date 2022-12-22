-- local cmd = vim.cmd
-- local fn = vim.fn

local M = {}

-- Pretty print a table (helps when messin' around)
M.dump = function(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. M.dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end

M.telescope_buffer_dir = function()
  return vim.fn.expand("%:p:h")
end

M.compact_browser = function()
  require("telescope").extensions.file_browser.file_browser({
    path = "%:p:h",
    cwd = M.telescope_buffer_dir(),
    respect_gitignore = false,
    hidden = true,
    grouped = true,
    previewer = false,
    initial_mode = "normal",
    layout_config = { height = 40 },
  })
end

-- Waiting for an API, like https://github.com/neovim/neovim/pull/19238
M.abbrev = function(l, r)
  vim.cmd{ cmd = 'abbrev', args = { l, r } }
end

return M
