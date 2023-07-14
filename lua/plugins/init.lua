return {
  'tpope/vim-fugitive',
  'tpope/vim-sleuth',
  { 'numToStr/Comment.nvim', opts = {} },
  {
    dir = "/home/marian/Projects/sitrusbuddy.nvim",
    dependencies = { "tjdevries/colorbuddy.vim" },
    config = function()
      require("colorbuddy").colorscheme("sitrusbuddy")
    end,
    -- lazy = false,
  },
}
