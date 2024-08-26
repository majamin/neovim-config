return {
  { "tpope/vim-surround", event = "VeryLazy" },
  { "tpope/vim-fugitive" },
  {
    "echasnovski/mini.tabline",
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
  { "numToStr/Comment.nvim", opts = {} },
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
    "jpalardy/vim-slime",
    config = function()
      vim.cmd("let g:slime_target = 'tmux'")
    end,
  },
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
}
