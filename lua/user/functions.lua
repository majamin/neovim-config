-- local cmd = vim.cmd
-- local fn = vim.fn

local M = {}

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

return M
