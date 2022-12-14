-- [[ USER CONFIGURATION ]]
-- The only file you need to edit (probably)

local M = {}

-- [[ ASSISTANCE AND AUTOMATION ]]
M.whichkey = false -- show key completion hints (enable with `:WhichKey`)
M.autocmp = false -- auto completions? (`C-n` for manual completion)
M.autofmt = false -- autoformat on save? (`C-l f` to manually format)

-- [[ LOCALE AND BASICS ]]
M.mapleader = ";"
M.lang = "en_ca" -- Canadian English
-- M.lang = "en_us" -- US English

-- [[ APPEARANCE ]]
M.background = "dark" -- "light", or "transparent"
M.lualine_theme = "auto" -- see 'https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md'
M.colorscheme = "duskfox"
-- M.colorscheme = "tokyonight"
-- M.colorscheme = "gruvbox"
-- M.colorscheme = "nightfox"
-- M.colorscheme = "terafox"

-- [[ LSP AND TREESITTER ]]
-- Treesitter languages (automatic)
M.treesitter_langs = {
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
  "query", -- treesitter/playground
  "r",
  "toml",
  "typescript",
  "vue",
  "yaml",
}

-- LSP servers
-- These will be installed and setup automatically.
-- For nice usage, some LSP servers require overrides (see below).
M.lsp_servers = {
  "sumneko_lua",
  "tsserver",
  "cssls",
  "volar",
  "tailwindcss",
  "pyright",
  "rust_analyzer",
  "html",
  "intelephense",
}

-- Optional LSP setting overrides
-- Defaults here: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
M.overrides = {
  Lua = {
    diagnostics = {
      globals = { "vim" }, -- removes that annoying "vim global not defined warning"
    },
    workspace = {
      library = vim.api.nvim_get_runtime_file("", true),
      checkThirdParty = false,
    },
  },
  cssls = { format = { enable = false } },
  tsserver = {
    filetypes = { "typescript", "typescriptreact", "typescript.tsx" },
    cmd = { "typescript-language-server", "--stdio" },
  },
  -- https://rust-analyzer.github.io/manual.html#nvim-lsp
  ["rust-analyzer"] = {
    imports = {
      granularity = {
        group = "module",
      },
      prefix = "self",
    },
    cargo = {
      buildScripts = {
        enable = true,
      },
    },
    procMacro = {
      enable = true,
    },
  },
  -- Use take-over mode (if you don't use Vue, you don't need this)
  volar = {
    filetypes = { "typescript", "javascript", "javascriptreact", "typescriptreact", "vue", "json" },
  },
}

return M
