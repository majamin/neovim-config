-- NOTE: This should be the only file you need to edit in the config

-- PREFERENCES --
local M = {
  lang = "en_ca", -- see :h locale-name
  mapleader = ";",
  maplocalleader = ";",
  colorscheme_if_dark = "tokyonight-moon", -- add more in plugins/colorscheme.lua
  colorscheme_if_light = "github_light",
  colorscheme_fallback = "slate",
  bg_is_transparent = true,
  format_on_save = true, -- manually format with '\'
  autocmp = false, -- autocompletion - trigger manually with C-n
  -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
  --  If you are experiencing weird indenting issues, add the language to
  --  the list of additional_vim_regex_highlighting and disabled languages for indent.
  additional_vim_regex_highlighting = { "ruby" },
}

-- LSP servers that are already installed and only need to be setup
M.servers_setup_only = {
  r_language_server = {},
  hls = {},
}

-- LSP servers that will be installed and setup by mason-tool-installer
M.servers = {
  clangd = {},
  gopls = {},
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
  marksman = {},
  pyright = {},
  rust_analyzer = {},
  texlab = {},
  ts_ls = {
    init_options = {
      plugins = {
        {
          name = "@vue/typescript-plugin",
          location = "./node_modules/@vue/typescript-plugin",
          languages = { "javascript", "typescript", "vue" },
        },
      },
    },
    filetypes = {
      "javascript",
      "typescript",
      "vue",
    },
  },
  volar = {},
}

-- Formatters (managing by conform) -- See lua/plugins/style.lua
M.formatters_by_ft = {
  lua = { "stylua" },
  json = { "prettierd", "prettier" },
  javascript = { "prettierd", "prettier" },
  typescript = { "prettierd", "prettier" },
  tex = { "latexindent" },
  markdown = { "markdownlint", "prettierd", "prettier" },
  ["*"] = { "codespell" }, -- always run
  ["_"] = { "trim_whitespace" },
  python = { "isort", "black" },
  bash = { "shellcheck", "shfmt" },
  zsh = { "shellcheck", "shfmt" },
  sh = { "shellcheck", "shfmt" },
}

-- Get all unique formatters from M.formatters_by_ft
-- Exclude "codespell" and "trim_whitespace"
M.formatters = {}
for _, v in pairs(M.formatters_by_ft) do
  for _, f in pairs(v) do
    if f ~= "codespell" and f ~= "trim_whitespace" then
      table.insert(M.formatters, f)
    end
  end
end

-- Used in lua/plugins/treesitter.lua
-- Automatically installs:
M.treesitter_ensure_installed = {
  "bash",
  "c",
  "css",
  "diff",
  "dockerfile",
  "html",
  "hyprlang",
  "javascript",
  "jsdoc",
  "json",
  "jsonc",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "python",
  "query",
  "rasi",
  "regex",
  "toml",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

-- VIM OPTIONS --
local o = vim.opt
local wo = vim.wo
local g = vim.g

-- stylua: ignore start
g.have_nerd_font = true                                       -- set to false if you don't have a nerd font
o.backspace = ""                                              -- influences the working of <BS>, etc. see `:h 'backspace'`
o.backup = false                                              -- <true|false> make a backup before overwriting a file?
o.breakindent = true                                          -- <true|false> Will every wrapped line continue visually indented?
o.cmdheight = 1                                               -- <int> space for displaying messages/commands?
o.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- options for Insert mode completion
o.conceallevel = 3                                            -- {0,1,2,3} Determine how text with "conceal" is shown
o.cursorline = false                                          -- <true|false> highlight the current line?
o.expandtab = true                                            -- <true | false> convert tabs to spaces?
o.fileencoding = "utf-8"                                      -- <fileencodings> file-content encoding for the current buffer
o.foldcolumn = "1"                                            -- <string> 'auto' or number of columns to use for the fold column
o.foldenable = false                                          -- <true|false> don't start files folded; enable with zi; wait for https://github.com/neovim/neovim/pull/17446
o.foldlevelstart = 99                                         -- <int> using ufo provider need a large value, feel free to decrease the value
o.history = 500                                               -- <number> a history of ":" and search commands (max 10000)
o.hlsearch = true                                             -- <boolean> highlight all matches on previous search pattern
o.ignorecase = false                                          -- <boolean> ignore case in search patterns
o.laststatus = 3                                              -- {0,1,2,3} should the last window will have a status line? See `:h laststatus`
o.lazyredraw = true                                           -- <boolean> redraw screen while running macros? (true = faster)
o.list = true                                                 -- <boolean> show some invisible characters (tabs, eol, etc.)
o.mouse = ""                                                  -- <string> enable mouse support in which situations? See `:h 'mouse'`
o.number = true                                               -- <boolean> print the line number in front of each line?
o.path = ".,**"                                               -- <string> search paths. See `:h 'path'` and `:h starstar-wildcard`
o.relativenumber = true                                       -- <boolean> show relative line numbers?
o.scrolloff = 3                                               -- <number> minimum number of screen lines to keep above and below the cursor
o.shiftwidth = 2                                              -- <number> the number of spaces inserted for each indentation
o.shortmess = o.shortmess + "c"                               -- prevent "pattern not found" messages
o.showmode = false                                            -- <boolean> show the mode? (redundant if mode is built into the statusline)
o.sidescrolloff = 5                                           -- <number> the minimal number of columns to scroll horizontally
o.signcolumn = "yes"                                          -- <string> in {auto, no, yes, 1-9} - "yes" prevents gutter opening and closing spastically
o.smartcase = true                                            -- <boolean> override the 'ignorecase' option if the search pattern contains upper case characters?
o.smartindent = true                                          -- <boolean> make indenting smarter again?
o.spelllang = M.lang or "en_us"                               -- <string> language(s) to use for spell checking
o.splitbelow = true                                           -- <boolean> force all horizontal splits to go below current window?
o.splitright = true                                           -- <boolean> force all vertical splits to go to the right of current window?
o.swapfile = true                                             -- <boolean> enable/disable swap file creation?
o.tabstop = 2                                                 -- <number> default: 8 - how many columns does a tab counts for?
o.termguicolors = true                                        -- <boolean> enable 24-bit RGB color in the TUI?
o.timeoutlen = 400                                            -- <number> time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0                                             -- <number> time in milliseconds to wait for a key code sequence to complete
o.undofile = true                                             -- <boolean> enable/disable undo file creation?
o.updatetime = 1000                                           -- <number> if nothing is typed after this many milliseconds the swap file will be written to disk
o.wildignorecase = true                                       -- <boolean> ignore setcase when completing file names and directories?
o.wildmode = "full"                                           -- <string> how to complete file names and directories
o.wrap = false                                                -- <boolean> wrap lines at the screen edge?
wo.foldexpr =
"nvim_treesitter#foldexpr()"                                  -- foldexpr for treesitter. See `:h fold-expr` and `:h nvim_treesitter#foldexpr()`
wo.foldmethod = "expr"                                        -- <string> foldmethod to use. See `:h foldmethod`
-- stylua: ignore end

return M
