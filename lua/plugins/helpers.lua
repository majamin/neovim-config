return {
  { "tpope/vim-sleuth", event = "VeryLazy" }, -- https://github.com/tpope/vim-sleuth
  { "tpope/vim-surround", event = "VeryLazy" }, -- https://github.com/tpope/vim-surround
  { "tpope/vim-fugitive" }, -- https://github.com/tpope/vim-fugitive
  { "numToStr/Comment.nvim", opts = {} },
  {
    "jpalardy/vim-slime",
    config = function()
      vim.cmd("let g:slime_target = 'tmux'")
    end,
  },
  {
    "github/copilot.vim",
    config = function()
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
    end,
    cmd = "Copilot",
  },
}
