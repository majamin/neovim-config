return {
  { "tpope/vim-sleuth", event = "VeryLazy" },
  { "tpope/vim-surround", event = "VeryLazy" },
  { "famiu/bufdelete.nvim", cmd = { "Bdelete" }, event = "VeryLazy" },
  { "windwp/nvim-autopairs", config = true, event = "VeryLazy" },
  { "numToStr/Comment.nvim", config = true, event = "VeryLazy" },
  { "lewis6991/gitsigns.nvim", config = true, event = "VeryLazy" },
  { "norcalli/nvim-colorizer.lua", config = true },
  {
    "jpalardy/vim-slime",
    config = function()
      vim.cmd("let g:slime_target = 'tmux'")
    end,
  },
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set('i', '<C-J>', 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false
      })
      vim.g.copilot_no_tab_map = true
    end,
  },
  {
    "echasnovski/mini.tabline",
    config = true,
    event = "VeryLazy",
    version = "*",
  },
}
