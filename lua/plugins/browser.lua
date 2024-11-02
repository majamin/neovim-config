local M = {
  "stevearc/oil.nvim", -- https://github.com/stevearc/oil.nvim/releases
  cmd = { "Oil" },
}

M.config = function()
  -- https://github.com/stevearc/oil.nvim/pull/240
  local permission_hlgroups = {
    ["-"] = "NonText",
    ["r"] = "DiagnosticSignWarn",
    ["w"] = "DiagnosticSignError",
    ["x"] = "DiagnosticSignOk",
  }

  require("oil").setup({
    columns = {
      {
        "permissions",
        highlight = function(permission_str)
          local hls = {}
          for i = 1, #permission_str do
            local char = permission_str:sub(i, i)
            table.insert(hls, { permission_hlgroups[char], i - 1, i })
          end
          return hls
        end,
      },
      { "size", highlight = "Special" },
      { "mtime", highlight = "Number" },
      {
        "icon",
        default_file = "",
        directory = "",
        add_padding = false,
      },
    },
    skip_confirm_for_simple_edits = true,
    win_options = {
      number = false,
      relativenumber = false,
      signcolumn = "no",
      foldcolumn = "0",
      statuscolumn = "",
    },
    keymaps = {
      ["<ESC>"] = "actions.close",
    },
  })
end

M.keys = {
  {
    "-",
    "<cmd>:Oil<CR>",
    { "n" },
    { desc = "Open parent directory" },
  },
}

return M
