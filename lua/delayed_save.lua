-- Save a buffer a few seconds after typing stops, in insert mode as well.
-- Used by braindump.lua (SUPER+SHIFT+D) and tasks.lua (SUPER+SHIFT+T).
--
--   require("delayed_save").setup(buf, save, 3000)
--
-- save is the function that writes the buffer; every change restarts the
-- countdown, so it runs once the typing has paused for that many milliseconds.

local M = {}

function M.setup(buf, save, ms)
  local timer = vim.uv.new_timer()
  vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
    group = vim.api.nvim_create_augroup("delayed_save_" .. buf, { clear = true }),
    buffer = buf,
    callback = function()
      timer:stop()
      timer:start(ms or 3000, 0, vim.schedule_wrap(save))
    end,
  })
  vim.api.nvim_create_autocmd("BufWipeout", {
    buffer = buf,
    once = true,
    callback = function()
      timer:stop()
      timer:close()
    end,
  })
end

return M
