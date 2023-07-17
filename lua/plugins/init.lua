return {
  { "tpope/vim-fugitive",                     event = "VeryLazy" },
  { "tpope/vim-sleuth",                       event = "VeryLazy" },
  { "tpope/vim-surround",                     event = "VeryLazy" },
  { "windwp/nvim-ts-autotag",                 config = true,     event = "VeryLazy" },
  { "windwp/nvim-autopairs",                  config = true,     event = "VeryLazy" },
  { "numToStr/Comment.nvim",                  config = true,     event = "VeryLazy" },
  { "lewis6991/gitsigns.nvim",                config = true,     event = "VeryLazy" },
  {
    "mbbill/undotree",
    keys = {
      {
        "U",
        "<cmd>UndotreeToggle|UndotreeFocus<CR>",
        desc = "Open Undotree",
        { silent = true },
      },
    },
  },
}
