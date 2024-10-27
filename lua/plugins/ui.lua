return {
  {
    "echasnovski/mini.tabline", -- https://github.com/echasnovski/mini.tabline
    opts = {},
    event = "VeryLazy",
    version = "*",
  },
  {
    "echasnovski/mini.statusline",
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
    end,
  },
  {
    "folke/todo-comments.nvim", -- https://github.com/folke/todo-comments.nvim/releases
    opts = { highlight = { keyword = "fg", after = "" } }, -- TODO: jkaskdjhkhasdkh
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
  },
  {
    "folke/trouble.nvim", -- https://github.com/folke/trouble.nvim/releases
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
    "lewis6991/gitsigns.nvim", -- https://github.com/lewis6991/gitsigns.nvim/releases
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
}
