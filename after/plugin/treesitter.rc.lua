local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- See https://github.com/nvim-treesitter/nvim-treesitter#available-modules
ts.setup({
  ensure_installed = {
    "typescript",
    "tsx",
    "toml",
    "php",
    "json",
    "yaml",
    "css",
    "html",
    "lua",
    "vue",
  },
  highlight = {
    enable = true,
    disable = {},
  },
  indent = {
    enable = true,
    disable = {},
  },
  autotag = {
    enable = true,
  },
  -- 'nvim-treesitter-incremental-selection-mod'
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
})

local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
parser_config.tsx.filetype_to_parsername = { "javascript", "typescript.tsx" }
