local M = {
  "mhartington/formatter.nvim",
}

local formatter_prettierd =
    function()
      return {
        exe = "prettierd",
        args = { vim.api.nvim_buf_get_name(0) },
        stdin = true
      }
    end

M.config = function()
  -- Utilities for creating configurations
  local util = require "formatter.util"

  -- Provides the Format, FormatWrite, FormatLock, and FormatWriteLock commands
  require("formatter").setup {
    -- Enable or disable logging
    logging = true,
    -- Set the log level
    log_level = vim.log.levels.WARN,
    -- All formatter configurations are opt-in
    filetype = {
      -- Formatter configurations for filetype "lua" go here
      -- and will be executed in order
      html = { formatter_prettierd },
      css = { formatter_prettierd },
      javascript = { formatter_prettierd },
      typescript = { formatter_prettierd },
      javascriptreact = { formatter_prettierd },
      typescriptreact = { formatter_prettierd },
      vue = { formatter_prettierd },
      lua = {
        -- "formatter.filetypes.lua" defines default configurations for the
        -- "lua" filetype
        require("formatter.filetypes.lua").stylua,

        -- You can also define your own configuration
        function()
          -- Supports conditional formatting
          if util.get_current_buffer_file_name() == "special.lua" then
            return nil
          end

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
        end
      },

      -- Use the special "*" filetype for defining formatter configurations on
      -- any filetype
      ["*"] = {
        -- "formatter.filetypes.any" defines default configurations for any
        -- filetype
        require("formatter.filetypes.any").remove_trailing_whitespace
      }
    }
  }
end

return M
