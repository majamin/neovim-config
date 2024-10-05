local M = {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
}

M.config = function()
  vim.filetype.add({
    extension = { rasi = "rasi" },
    pattern = {
      [".*/waybar/config"] = "jsonc",
      [".*/mako/config"] = "dosini",
      [".*/kitty/*.conf"] = "bash",
      [".*/hypr/.*%.conf"] = "hyprlang",
    },
  })

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
    ensure_installed = require("user.opts").treesitter_ensure_installed,
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = require("user.opts").additional_vim_regex_highlighting,
    },
    indent = {
      enable = true,
      disable = require("user.opts").additional_vim_regex_highlighting,
    },
  })
end

return M
