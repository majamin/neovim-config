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

local o = vim.opt
local wo = vim.wo
local g = vim.g

g.vimwiki_global_ext = 0 -- Don't vimwiki every goddamn md file, please
g.vimwiki_url_maxsave = 0 -- Don't shorten URL so you can plumb links
g.vimwiki_list = { { path = M.primary_vimwiki_path } }

o.backup = false -- creates a backup file
o.breakindent = true
o.cmdheight = 1 -- space for displaying messages/commands
o.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- A comma separated list of options for Insert mode completion
o.conceallevel = 0 -- so that `` is visible in markdown files
o.cursorline = false -- highlight the current line
o.expandtab = true -- convert tabs to spaces
o.fileencoding = "utf-8" -- the encoding written to a file
o.foldcolumn = "1"
o.foldenable = false -- don't start files folded; enable with zi; wait for https://github.com/neovim/neovim/pull/17446
o.foldlevelstart = 99 -- Using ufo provider need a large value, feel free to decrease the value
wo.foldmethod = "expr"
wo.foldexpr = "nvim_treesitter#foldexpr()"
o.history = 500 -- Use the 'history' option to set the number of lines from command mode that are remembered.
o.hlsearch = true -- highlight all matches on previous search pattern
o.ignorecase = false -- ignore case in search patterns
o.laststatus = 3 -- global statusline = 3
o.lazyredraw = true -- do not redraw screen while running macros
o.list = true
o.mouse = "" -- I use tmux to grab text from the screen
o.number = true -- show line numbers (or only the current one)
o.relativenumber = true -- relative line numbers
o.path = ".,**"
o.scrolloff = 3 -- Minimal number of screen lines to keep above and below the cursor
o.shiftwidth = 2 -- the number of spaces inserted for each indentation
o.shortmess = o.shortmess + "c" -- prevent "pattern not found" messages
o.showmode = false -- mode is built into the statusline so let's leave it out
o.sidescrolloff = 5 -- the minimal number of columns to scroll horizontally
o.signcolumn = "yes" -- "yes" ensures that the gutter doesn't open and close spastically
o.smartcase = true -- smart case
o.smartindent = true -- make indenting smarter again
o.spelllang = M.lang or "en_us"
o.splitbelow = true -- force all horizontal splits to go below current window
o.splitright = true -- force all vertical splits to go to the right of current window
o.swapfile = true -- enable/disable swap file creation
o.tabstop = 2 -- how many columns a tab counts for
o.termguicolors = true -- set term gui colors (most terminals support this)
o.timeoutlen = 400 -- time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0 -- time in milliseconds to wait for a key code sequence to complete
o.undofile = true -- enable/disable undo file creation
o.updatetime = 250 -- faster completion
o.wildignorecase = true -- set case is ignored when completing file names and directories
o.wildmode = "full"
o.wrap = false

-- e.g. These servers are installed, mason will ignore
M.mason_ignore = { "hls" }

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
}

return M
