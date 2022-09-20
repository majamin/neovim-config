local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- See https://github.com/nvim-treesitter/nvim-treesitter#available-modules
ts.setup({
  ensure_installed = {
    "bash",
    "cmake",
    "css",
    "dockerfile",
    "go",
    "hcl",
    "html",
    "java",
    "javascript",
    "json",
    "latex",
    "lua",
    "markdown",
    "python",
    "query", -- for treesitter/playground
    "toml",
    "typescript",
    "vue",
    "yaml",
  },
  highlight = { enable = true },
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
