return {
  { "github/copilot.vim" },
  { "tpope/vim-fugitive",       cmd = { "Git" } },
  { "famiu/bufdelete.nvim",     cmd = { "Bdelete" } },
  { "tpope/vim-sleuth",         event = "VeryLazy" },
  { "tpope/vim-surround",       event = "VeryLazy" },
  { "windwp/nvim-ts-autotag",   config = true,      event = "VeryLazy" },
  { "windwp/nvim-autopairs",    config = true,      event = "VeryLazy" },
  { "numToStr/Comment.nvim",    config = true,      event = "VeryLazy" },
  { "lewis6991/gitsigns.nvim",  config = true,      event = "VeryLazy" },
  { 'echasnovski/mini.tabline', config = true,      version = '*' },
  {
    "mbbill/undotree",
    config = function()
      vim.cmd([[let g:undotree_WindowLayout = 4]])
    end,
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
