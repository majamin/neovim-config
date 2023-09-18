-- BASIC SETTINGS --
local M = {
  lang = "en_ca", -- or en_us, etc.
  colorscheme = "tokyonight",
  autocmp = true,
  whichkey = true,
  primary_vimwiki_path = "/home/marian/Maja/Projects/notes",
  lazy_opts = {
    change_detection = {
      enabled = true,
      notify = false,
    },
  },
}

-- DEVELOPMENT --

-- These are already installed, Mason will ensure that they are loaded only
M.mason_ignore = { "hls", "rustfmt" }

-- Your dev settings for lspconfig and mason
M.dev = {
  lua_ls = {
    settings = {
      Lua = {
        workspace = { checkThirdParty = false },
        telemetry = { enable = false },
      },
    },
    formatter = "stylua",
  },
  pyright = {
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace",
        },
      },
    },
    formatter = "black",
  },
  tsserver = {
    settings = {
      documentFormatting = false,
    },
    formatter = "prettierd",
    filetypes = {
      "javascript",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
    },
  },
  clangd = {
    settings = {},
    formatter = "clang-format",
  },
  rust_analyzer = {
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy",
        },
      },
    },
    formatter = "rustfmt",
  },
  emmet_ls = {
    settings = {
      filetypes = require("user/data").emmet_filetypes,
      init_options = {
        html = {
          options = {
            -- For possible options, see: https://github.com/emmetio/emmet/blob/master/src/config.ts#L79-L267
            ["bem.enabled"] = true,
            ["jsx.enabled"] = true,
          },
        },
      },
    },
    formatter = "prettierd",
  },
  hls = {
    settings = {
      haskell = {
        formattingProvider = "fourmolu",
      },
    },
  },
  tailwindcss = {
    settings = {
      filetypes = require("user/data").tailwindcss_filetypes,
    },
  },
  gopls = {
    settings = {
      analyses = {
        unusedparams = true,
      },
      staticcheck = true,
      gofumpt = true,
    },
    formatter = "gofumpt",
  },
}

return M
