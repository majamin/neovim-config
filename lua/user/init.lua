-- BASIC SETTINGS --
local M = {
  lang = "en_ca", -- see :h locale-name
  mapleader = ";",
  maplocalleader = ";",
  colorscheme = "tokyonight-moon",
  format_on_save = false, -- manually format with <leader>lf
  has_nerd_font = true,   -- does your font and terminal allow nerd fonts?
  autocmp = false,        -- autocompletion - trigger manually with C-n
}

-- LSP Servers -- See lua/plugins/lsp.lua
M.servers = {
  clangd = {},
  -- ... etc. See `:help lspconfig-all` for a list of all the pre-configured LSPs
  lua_ls = {
    -- cmd = {...},         -- (table) override the default command
    -- filetypes = {...},   -- (table) override the default list of associated filetypes
    -- capabilities = {},   -- (table) override fields in capabilities
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
          },
        },
      },
    },
  },
  texlab = {},
  tsserver = {},
  rust_analyzer = {},
  r_language_server = {},
  marksman = {},
}

-- Formatters (managing by conform) -- See lua/plugins/style.lua
M.formatters_by_ft = {
  lua = { "stylua" },
  javascript = { { "prettierd", "prettier" } },
  typescript = { { "prettierd", "prettier" } },
  tex = { "latexindent" },
  -- Run multiple formatters sequentially:
  -- python = { "isort", "black" },
}

return M
