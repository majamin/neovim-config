local M = {}

-- Use git files or fallback to normal find_files
M.project_files = function()
  if not pcall(require, "telescope.builtin") then
    print("Telescope.builtin not accessible")
    return
  end
  local opts = {} -- define here if you want to define something
  vim.fn.system("git rev-parse --is-inside-work-tree")
  if vim.v.shell_error == 0 then
    require("telescope.builtin").git_files(opts)
  else
    require("telescope.builtin").find_files(opts)
  end
end

-- Waiting for an API, like https://github.com/neovim/neovim/pull/19238
M.abbrev = function(l, r)
  vim.cmd({ cmd = "abbrev", args = { l, r } })
end

return M
