-- Brain dump session, started by ~/.local/bin/brain-dump. Opens the note in
-- Zen Mode, saves it as you type, and makes :q save and quit Neovim instead of
-- only closing the Zen window. A note left empty is not kept.

local buf = vim.api.nvim_get_current_buf()
local file = vim.api.nvim_buf_get_name(buf)

local function is_empty()
  local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  return #lines == 1 and lines[1] == ""
end

local function save()
  if not vim.api.nvim_buf_is_valid(buf) then return end
  if is_empty() then
    os.remove(file)
    return
  end
  vim.api.nvim_buf_call(buf, function() vim.cmd("silent! update") end)
end

vim.api.nvim_create_autocmd({ "InsertLeave", "FocusLost", "VimLeavePre" }, {
  group = vim.api.nvim_create_augroup("braindump", { clear = true }),
  callback = save,
})

-- and 3 seconds after typing stops
require("delayed_save").setup(buf, save, 3000)

require("zen-mode").open({
  on_close = function()
    vim.schedule(function()
      save()
      vim.cmd("qa!")
    end)
  end,
})

vim.cmd("startinsert")
