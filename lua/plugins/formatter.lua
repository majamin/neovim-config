local M = {
  "mhartington/formatter.nvim",
  event = "VeryLazy",
}

local formatter_prettierd = function()
  return {
    exe = "prettierd",
    args = { vim.api.nvim_buf_get_name(0) },
    stdin = true,
  }
end

M.config = function()
  -- Utilities for creating configurations
  local util = require("formatter.util")

  -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
  require("formatter").setup({
    logging = true,
    log_level = vim.log.levels.WARN,
    filetype = {
      python = {
        function()
          return { exe = "black", args = { "-" }, stdin = true }
        end,
      },
      c = {
        function()
          return { exe = "clang-format", args = { "-" }, stdin = true }
        end,
      },
      cpp = {
        function()
          return { exe = "clang-format", args = { "-" }, stdin = true }
        end,
      },
      html = { formatter_prettierd },
      css = { formatter_prettierd },
      javascript = { formatter_prettierd },
      typescript = { formatter_prettierd },
      javascriptreact = { formatter_prettierd },
      typescriptreact = { formatter_prettierd },
      vue = { formatter_prettierd },
      lua = {
        require("formatter.filetypes.lua").stylua,

        function()
          -- Return nil on a condition (example)
          -- if util.get_current_buffer_file_name() == "special.lua" then
          --   return nil
          -- end

          -- Full specification of configurations is down below and in Vim help
          -- files
          return {
            exe = "stylua",
            args = {
              "--search-parent-directories",
              "--stdin-filepath",
              util.escape_path(util.get_current_buffer_file_path()),
              "--",
              "-",
            },
            stdin = true,
          }
        end,
      },
      haskell = {
        function()
          return {
            exe = "fourmolu",
            args = { "-i", vim.api.nvim_buf_get_name(0) },
            stdin = false,
          }
        end,
      },
      -- Fallback formatter (remove whitespace)
      ["*"] = {
        require("formatter.filetypes.any").remove_trailing_whitespace,
      },
    },
  })
end

return M
