local M = {
  "stevearc/conform.nvim", -- https://github.com/stevearc/conform.nvim/releases
  lazy = false,
}
M.keys = {
  {
    "<leader>lf",
    function()
      require("conform").format({ async = true, lsp_fallback = true })
    end,
    mode = "",
    desc = "Format buffer",
  },
}

M.opts = {
  notify_on_error = false,
  format_on_save = function(bufnr)
    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    if require("user").format_on_save then
      return {
        timeout_ms = 500,
        lsp_fallback = not disable_filetypes[vim.bo[bufnr].filetype],
      }
    else
      return
    end
  end,
  formatters_by_ft = require("user").formatters_by_ft,
}

return M
