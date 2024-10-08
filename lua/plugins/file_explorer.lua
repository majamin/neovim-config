local M = {
  "stevearc/oil.nvim", -- https://github.com/stevearc/oil.nvim/releases
  cmd = { "Oil" },
}

M.config = function()
  require("oil").setup({
    default_file_explorer = true,
    skip_confirm_for_simple_edits = true,
    float = {
      -- Padding around the floating window
      max_width = 60,
      border = "rounded",
      max_height = 30,
      win_options = {
        winblend = 10,
      },
      -- This is the config that will be passed to nvim_open_win.
      -- Change values here to customize the layout
      override = function(conf)
        return conf
      end,
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
