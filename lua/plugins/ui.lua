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
    opts = { highlight = { keyword = "fg", after = "" } },
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
      modes = { -- https://github.com/folke/trouble.nvim/blob/main/docs/examples.md#diagnostics-cascade
        cascade = {
          mode = "diagnostics", -- inherit from diagnostics mode
          filter = function(items)
            local severity = vim.diagnostic.severity.HINT
            for _, item in ipairs(items) do
              severity = math.min(severity, item.severity)
            end
            return vim.tbl_filter(function(item)
              return item.severity == severity
            end, items)
          end,
        },
      },
    },
    keys = {
      {
        "<leader>t",
        "<cmd>Trouble cascade toggle focus=false<CR>",
        desc = "Navigate cascading diagnostics",
      },
      {
        "<leader>s",
        "<cmd>Trouble symbols toggle pinned=true win.relative=win win.position=right<CR>",
        desc = "Navigate document symbols",
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
