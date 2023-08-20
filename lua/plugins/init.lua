return {
  { "github/copilot.vim" },
  { "tpope/vim-fugitive",       cmd = { "Git" } },
  { "famiu/bufdelete.nvim",     cmd = { "Bdelete" } },
  { "tpope/vim-sleuth",         event = "VeryLazy" },
  { "tpope/vim-surround",       event = "VeryLazy" },
  { "windwp/nvim-ts-autotag",   config = true,            event = "VeryLazy" },
  { "windwp/nvim-autopairs",    config = true,            event = "VeryLazy" },
  { "numToStr/Comment.nvim",    config = true,            event = "VeryLazy" },
  { "lewis6991/gitsigns.nvim",  config = true,            event = "VeryLazy" },
  { "echasnovski/mini.tabline", config = true,            version = "*" },
  { "folke/todo-comments.nvim", opts = { signs = false }, dependencies = { "nvim-lua/plenary.nvim" }, }
}
