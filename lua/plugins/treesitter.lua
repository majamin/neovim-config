local M = {
  "nvim-treesitter/nvim-treesitter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/playground",
  },
  build = ":TSUpdate",
  event = "VeryLazy",
}

local langs = {}
local user_wants_dev = require("user").dev
local contains = require("user/funs").contains

table.insert(langs, "vim")
table.insert(langs, "vimdoc")

if contains(user_wants_dev, "c") then
  table.insert(langs, "c")
  table.insert(langs, "cpp")
end

if contains(user_wants_dev, "javascript") then
  table.insert(langs, "typescript")
end

if contains(user_wants_dev, "web") then
  table.insert(langs, "tsx")
  table.insert(langs, "html")
end

if contains(user_wants_dev, "go") then
  table.insert(langs, "go")
end

if contains(user_wants_dev, "rust") then
  table.insert(langs, "rust")
end

if contains(user_wants_dev, "python") then
  table.insert(langs, "python")
end

M.config = function()
  require("nvim-treesitter.configs").setup({
    ensure_installed = langs,
    auto_install = true,
    highlight = { enable = true },
    indent = { enable = true },
    autotag = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<space>",
        -- node_incremental = '<space>',
        scope_incremental = "<space>",
        node_decremental = "<backspace>",
      },
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["aa"] = "@parameter.outer",
          ["ia"] = "@parameter.inner",
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["ac"] = "@class.outer",
          ["ic"] = "@class.inner",
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          ["]m"] = "@function.outer",
          ["]]"] = "@class.outer",
        },
        goto_next_end = {
          ["]M"] = "@function.outer",
          ["]["] = "@class.outer",
        },
        goto_previous_start = {
          ["[m"] = "@function.outer",
          ["[["] = "@class.outer",
        },
        goto_previous_end = {
          ["[M"] = "@function.outer",
          ["[]"] = "@class.outer",
        },
      },
    },
  })
end

return M
