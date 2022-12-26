return {
  { "jpalardy/vim-slime" },
  { "tpope/vim-fugitive" },
  { "norcalli/nvim-colorizer.lua" },
  {
    "lukas-reineke/indent-blankline.nvim",
    dependencies = { "jesseleite/nvim-noirbuddy" }, -- fixes indent line colors
  },
  { "folke/zen-mode.nvim" },
  { "windwp/nvim-ts-autotag", ft = { "html", "tsx", "vue", "svelte", "php", "res" } },
  { "windwp/nvim-autopairs", config = true },
  { "numToStr/Comment.nvim", config = true },
  { "tpope/vim-surround" },
  { "famiu/bufdelete.nvim" },
}
