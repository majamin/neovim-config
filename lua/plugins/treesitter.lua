local M = {
  "nvim-treesitter/nvim-treesitter"
}

function M.config()
  -- See https://github.com/nvim-treesitter/nvim-treesitter#available-modules
  local ts = require("nvim-treesitter.configs")
  local langs = require("user").treesitter_langs
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
end

return M
