return {
  { "tpope/vim-fugitive" },
  { "norcalli/nvim-colorizer.lua" },
  { "lukas-reineke/indent-blankline.nvim" },
  { "windwp/nvim-ts-autotag", ft = { "html", "tsx", "vue", "svelte", "php", "res" } },
  { "windwp/nvim-autopairs", config = true },
  { "numToStr/Comment.nvim", config = true },
  { "tpope/vim-surround" },
  { "famiu/bufdelete.nvim" },
  { "mbbill/undotree", keys = { { "U", ":UndotreeToggle|UndotreeFocus<CR>" } } },
}
