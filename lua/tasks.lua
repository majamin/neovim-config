-- Tasks session, started by ~/.local/bin/tasks-open (SUPER+SHIFT+T). Opens
-- ~/tasks.md in Zen Mode, saves it as you type, and makes :q save and quit
-- Neovim instead of only closing the Zen window. Enter on a task line ticks
-- or unticks its box. tasks-open syncs with Google Tasks after Neovim exits.

local buf = vim.api.nvim_get_current_buf()

local function save()
  if not vim.api.nvim_buf_is_valid(buf) then return end
  vim.api.nvim_buf_call(buf, function() vim.cmd("silent! update") end)
end

vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "VimLeavePre" }, {
  group = vim.api.nvim_create_augroup("tasks", { clear = true }),
  callback = save,
})

-- and 3 seconds after typing stops
require("delayed_save").setup(buf, save, 3000)

vim.keymap.set("n", "<CR>", function()
  local line = vim.api.nvim_get_current_line()
  local new
  if line:match("^%s*[-*] %[ %]") then
    new = line:gsub("%[ %]", "[x]", 1)
  elseif line:match("^%s*[-*] %[[xX]%]") then
    new = line:gsub("%[[xX]%]", "[ ]", 1)
  end
  if new then
    vim.api.nvim_set_current_line(new)
  end
end, { buffer = buf, desc = "Tick or untick the task" })

require("zen-mode").open({
  on_close = function()
    vim.schedule(function()
      save()
      vim.cmd("qa!")
    end)
  end,
})
