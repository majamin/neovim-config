local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
}

M.opts = {
  ensure_installed = {
    "bash",
    "c",
    "diff",
    "html",
    "lua",
    "luadoc",
    "markdown",
    "vim",
    "vimdoc",
  },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = require("user.opts").additional_vim_regex_highlighting,
  },
  indent = {
    enable = true,
    disable = require("user.opts").additional_vim_regex_highlighting,
  },
}

M.config = function()
  require("nvim-treesitter.install").prefer_git = true
  require("nvim-treesitter.configs").setup({
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = " ",
        node_incremental = " ",
        scope_incremental = "gi",
         node_decremental = "gd",
      },
    },
  })
end

return M
