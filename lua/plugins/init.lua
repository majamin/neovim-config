return {
  { "github/copilot.vim" },
  { "tpope/vim-fugitive", cmd = { "Git" } },
  { "tpope/vim-sleuth", event = "VeryLazy" },
  { "tpope/vim-surround", event = "VeryLazy" },
  { "famiu/bufdelete.nvim", cmd = { "Bdelete" }, event = "VeryLazy" },
  { "windwp/nvim-autopairs", config = true, event = "VeryLazy" },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
  { "lewis6991/gitsigns.nvim", config = true, event = "VeryLazy" },
  { "jpalardy/vim-slime", config = function() vim.cmd("let g:slime_target = 'tmux'") end },
  {
    "echasnovski/mini.tabline",
    config = true,
    event = "VeryLazy",
    version = "*",
  },
  {
    "folke/todo-comments.nvim",
    opts = { signs = false },
    dependencies = { "nvim-lua/plenary.nvim" },
  },
}
