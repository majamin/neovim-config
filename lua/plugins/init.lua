return {
  { "tpope/vim-fugitive", cmd = { "Git" } },
  { "norcalli/nvim-colorizer.lua", ft = { "html", "tsx", "vue", "svelte", "php", "res", "markdown" } },
  { "lukas-reineke/indent-blankline.nvim" },
  { "windwp/nvim-ts-autotag", ft = { "html", "tsx", "vue", "svelte", "php", "res" } },
  { "windwp/nvim-autopairs", config = true },
  { "numToStr/Comment.nvim", config = true },
  { "tpope/vim-surround", keys = { "ys", "cs" } },
  { "famiu/bufdelete.nvim", cmd = { "Bdelete" } },
  { "mbbill/undotree", keys = { { "U", "<cmd>UndotreeToggle|UndotreeFocus<CR>", { silent = true } } } },
}
