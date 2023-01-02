------------------------------------------------------ [[ USER CONFIGURATION ]]
--                                    The only file you need to edit (probably)

local M = {}

M.primary_vimwiki_path = (os.getenv("ONEDRIVE") or "/home/marian/Maja") .. "/Projects/notes"

----------------------------------------------- [[ ASSISTANCE AND AUTOMATION ]]
M.whichkey = false -- show key completion hints?
M.autocmp = false -- enable auto completions? (`C-n` for manual completion)
M.autofmt = false -- enable autoformat on save? (`C-l f` to manually format)

------------------------------------------------------- [[ LOCALE AND BASICS ]]
M.mapleader = ";"
M.lang = "en_ca" -- Canadian English
-- M.lang = "en_us" -- US English

-------------------------------------------------------------- [[ APPEARANCE ]]
M.background = "dark" -- "light" or "dark"
M.bg_is_transparent = false -- boolean
M.lualine_theme = "auto" -- see 'https://github.com/nvim-lualine/lualine.nvim/blob/master/THEMES.md'
-- M.colorscheme = "noirbuddy" -- configure here: lua/plugins/noirbuddy.lua
-- M.colorscheme = "tokyonight"
-- M.colorscheme = "tokyonight-day"
-- M.colorscheme = "tokyonight-dusk"
-- M.colorscheme = "tokyonight-moon"
-- M.colorscheme = "tokyonight-night"
-- M.colorscheme = "carbonfox"
-- M.colorscheme = "dawnfox"
-- M.colorscheme = "dayfox"
M.colorscheme = "duskfox"
-- M.colorscheme = "nightfox"
-- M.colorscheme = "nordfox"
-- M.colorscheme = "terafox"
-- M.colorscheme = "gruvbox"

---------------------------------------------------------------[[ TREESITTER ]]
-- NOTE: these will be installed automatically

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

----------------------------------------------------------------------[[ LSP ]]
-- NOTE: these will be installed automatically
-- TODO: Some LSP servers require personal overrides (see below).

M.lsp_servers = {
  "cssls", -- css
  "html", -- html
  "intelephense", -- php
  "pyright", -- python
  "rust_analyzer", -- rust
  "sumneko_lua", -- lua
  "tailwindcss", -- tailwindcss
  "tsserver", -- js, jsx, ts, tsx
  "volar", -- vue
}

-- OVERRIDES
-- SEE: https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md
M.overrides = {
  Lua = {
    diagnostics = {
      globals = { "vim" }, -- removes that annoying "vim global not defined warning"
    },
    workspace = {
      library = vim.api.nvim_get_runtime_file("", true),
      checkThirdParty = false, -- HACK: is this a hack?
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

------------------------------------------------------------ [[ LAZY OPTIONS ]]
M.lazy_opts = {
  checker = {
    enabled = true,
    notify = false,
  },
  change_detection = {
    notify = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "matchit",
        "matchparen",
        "netrwPlugin",
        "tarPlugin",
        "tohtml",
        "tutor",
        "zipPlugin",
      },
    },
  },
}

return M
