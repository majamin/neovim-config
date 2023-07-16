return {
  "tpope/vim-fugitive",
  "tpope/vim-sleuth",
  "tpope/vim-surround",
  { "windwp/nvim-ts-autotag", config = true },
  { "windwp/nvim-autopairs", config = true },
  { "numToStr/Comment.nvim", opts = {} },
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
