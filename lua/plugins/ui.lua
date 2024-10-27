return {
  {
    "echasnovski/mini.tabline", -- https://github.com/echasnovski/mini.tabline
    config = true,
    event = "VeryLazy",
    version = "*",
  },
  {
    "folke/todo-comments.nvim",
    config = true,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
  },
  {
    "folke/trouble.nvim",
    cmd = "Trouble",
    opts = {
      focus = true,
      warn_no_results = false,
      open_no_results = true,
    },
    keys = {
      {
        "<leader>t",
        "<cmd>Trouble diagnostics toggle<cr>",
        desc = "Navigate diagnostics",
      },
      -- ["<leader>tl"] = { "<cmd>Trouble loclist<cr>", "" },
      -- ["<leader>tq"] = { "<cmd>Trouble quickfix<cr>", "" },
    },
    VeryLazy = true,
  },
  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
      },
    },
  },
  {
    "echasnovski/mini.nvim",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
}
