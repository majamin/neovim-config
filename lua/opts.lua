local M = {}
local o = vim.opt
local wo = vim.wo
local g = vim.g

-- stylua: ignore start
g.mapleader = " "                 -- <leader> is Space (set before lazy.nvim and any keymaps load)
g.have_nerd_font = true           -- set to false if you don't have a nerd font
o.backspace = ""                  -- influences the working of <BS>, etc. see `:h 'backspace'`
o.breakindent = true              -- <true|false> Will every wrapped line continue visually indented?
vim.schedule(function()
  o.clipboard = "unnamedplus"     -- <string> set clipboard mode - see `:h 'clipboard'`
end)
o.completeopt =
{
  "menu",
  "menuone",
  "noselect",
}                                 -- insert mode
o.conceallevel = 3                -- {0,1,2,3} Determine how text with "conceal" is shown
o.expandtab = true                -- <true | false> convert tabs to spaces?
o.fillchars = { fold = "·" }      -- see `:h 'fillchars'`
o.foldenable = false              -- <true|false> all folds closed on buffer open? (zi to toggle)
o.foldtext = "v:lua.myfolds()"    -- custom fold function (see _G.myfolds)
o.history = 500                   -- <number> a history of ":" and search commands (max 10000)
o.incsearch = true                -- <boolean> jump to the first search pattern as it's typed?
o.laststatus = 3                  -- {0,1,2,3} should the last window will have a status line? See `:h laststatus`
o.lazyredraw = true               -- <boolean> redraw screen while running macros? (true = faster)
o.list = true                     -- <boolean> show some invisible characters (tabs, eol, etc.)
o.number = true                   -- <boolean> print the line number in front of each line?
o.path = ".,**"                   -- <string> search paths. See `:h 'path'` and `:h starstar-wildcard`
o.relativenumber = true           -- <boolean> show relative line numbers?
o.scrolloff = 3                   -- <number> minimum number of screen lines to keep above and below the cursor
o.shell="/bin/zsh"                -- <string> path to shell command for !
o.shellcmdflag="-ic"              -- <string> arguments to shell command (useful to load environments)
o.shiftwidth = 2                  -- <number> the number of spaces inserted for each indentation
o.shortmess = o.shortmess + "c"   -- hide completion menu messages ("match 1 of 2", "Pattern not found")
o.showmode = false                -- <boolean> show the mode? (redundant if mode is built into the statusline)
o.sidescrolloff = 5               -- <number> the minimal number of columns to scroll horizontally
o.signcolumn = "yes"              -- <string> in {auto, no, yes, 1-9} - "yes" prevents gutter opening and closing spastically
o.smartindent = true              -- <boolean> make indenting smarter again?
o.spelllang = "en_ca"             -- <string> language(s) to use for spell checking
o.splitbelow = true               -- <boolean> force all horizontal splits to go below current window?
o.splitright = true               -- <boolean> force all vertical splits to go to the right of current window?
o.tabstop = 2                     -- <number> default: 8 - how many columns does a tab counts for?
o.timeoutlen = 400                -- <number> time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0                 -- <number> time in milliseconds to wait for a key code sequence to complete
o.undofile = true                 -- <boolean> enable/disable undo file creation?
o.updatetime = 250                -- <number> milliseconds of no typing before the swap file is written and CursorHold fires (LSP word highlight)
o.wildignorecase = true           -- <boolean> ignore setcase when completing file names and directories?
o.winborder = "single"
o.wrap = false                    -- <boolean> wrap lines at the screen edge?
o.confirm = true                  -- <boolean> dialog instead of error when quitting with unsaved changes
o.inccommand = "split"            -- <string> preview substitutions live in a split
o.listchars =
{
  tab = "» ",
  trail = "·",
  nbsp = "␣",
}
wo.foldexpr =
"v:lua.vim.treesitter.foldexpr()" -- foldexpr for treesitter. See `:h fold-expr` and `:h vim.treesitter.foldexpr()`
wo.foldmethod = "expr"            -- <string> foldmethod to use. See `:h foldmethod`
-- stylua: ignore end

vim.diagnostic.config({
  severity_sort = true,
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "● ",
      [vim.diagnostic.severity.WARN] = "● ",
      [vim.diagnostic.severity.INFO] = "● ",
      [vim.diagnostic.severity.HINT] = "󰌶 ",
    },
  },
  underline = true,
  virtual_text = false, -- tiny-inline-diagnostic.nvim draws the messages
  float = {
    source = "if_many",
    header = "",
    prefix = "",
    suffix = "",
  },
  -- jump = {
  --   -- ]d and [d skip warnings, info and hints
  --   severity = vim.diagnostic.severity.ERROR,
  -- },
})

M.special_formatters = {
  ["prettier-npx"] = {
    command = "npx",
    args = { "--yes", "prettier", "--stdin-filepath", "$FILENAME" },
    stdin = true,
  },
}

local prettier = { "prettierd", "prettier", "prettier-npx", stop_after_first = true }

-- The defaults:
M.formatters_by_ft = {
  bash = { "shfmt" },
  tex = { "latexindent" },
  lua = { "stylua" },
  haskell = { "fourmolu" },
  javascript = prettier,
  javascriptreact = prettier,
  json = prettier,
  typescript = prettier,
  typescriptreact = prettier,
  r = { "air" },
  rust = { "rustfmt" },
  svelte = prettier,
  toml = { "taplo" },
  typst = { "typstyle" },
  python = { "black" },
  vue = prettier,
  -- ["*"] = { "codespell" }, -- always run
}

M.treesitter_ensure_installed = {
  "bash",
  "c",
  "diff",
  "html",
  "javascript",
  "latex",
  "lua",
  "luadoc",
  "markdown",
  "markdown_inline",
  "query",
  "scss",
  "svelte",
  "tsx",
  "typst",
  "vim",
  "vimdoc",
  "vue",
}

-- Some languages/filetypes do not play well:
M.treesitter_noinstall_noenable = {
  tmux = true,
}

return M
