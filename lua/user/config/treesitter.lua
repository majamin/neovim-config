local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

local langs = require("user.user-conf").treesitter_langs

-- See https://github.com/nvim-treesitter/nvim-treesitter#available-modules
ts.setup({
  ensure_installed = langs,
  highlight = {
    enable = true,
  },
  endwise = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<space>",
      node_incremental = "<space>",
      scoce_incremental = "grc",
      node_decremental = "<backspace>",
    },
  },
})
