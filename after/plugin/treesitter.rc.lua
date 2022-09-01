local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

vim.cmd("TSUpdate")

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
  }, -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  ignore_install = {}, -- List of parsers to ignore installing
  highlight = {
    enable = true, -- false will disable the whole extension
    disable = {}, -- list of language that will be disabled
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<CR>",
      scope_incremental = "<CR>",
      node_incremental = "<TAB>",
      node_decremental = "<S-TAB>",
    },
  },
  endwise = {
    enable = true,
  },
  indent = { enable = true },
  autopairs = { enable = true },
  -- requires https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  textobjects = {
    select = {
      enable = true,
      -- Automatically jump forward to textobj, similar to targets.vim
      lookahead = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner",
        ["al"] = "@loop.outer",
        ["il"] = "@loop.inner",
        ["ib"] = "@block.inner",
        ["ab"] = "@block.outer",
        ["ir"] = "@parameter.inner",
        ["ar"] = "@parameter.outer",
      },
      lsp_interop = {
        enable = true,
        border = "none",
        peek_definition_code = {
          [";dF"] = "@function.outer",
          [";dC"] = "@class.outer",
        },
      },
    },
  },
})
