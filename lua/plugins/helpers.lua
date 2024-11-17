return {
  { "tpope/vim-sleuth" }, -- https://github.com/tpope/vim-sleuth
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
  {
    "lervag/vimtex",
    lazy = false, -- we don't want to lazy load VimTeX
    -- tag = "v2.15", -- uncomment to pin to a specific release
    init = function()
      -- VimTeX configuration goes here, e.g.
      vim.g.vimtex_view_method = "zathura"
    end,
  },
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false, -- It's already lazy
  },
}
