-- OPTIONS --
local M = {}

local o = vim.opt
local wo = vim.wo
local g = vim.g
local user = require("user")
local lang = user.lang

g.have_nerd_font = user.has_nerd_font

o.background = user.background
o.backspace = ""          -- influences the working of <BS>, etc. see `:h 'backspace'`
o.backup = false          -- <true|false> make a backup before overwriting a file?
o.breakindent = true      -- <true|false> Will every wrapped line continue visually indented?
o.cmdheight = 1           -- <int> space for displaying messages/commands?
o.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- options for Insert mode completion
o.conceallevel = 3        -- {0,1,2,3} Determine how text with "conceal" is shown
o.cursorline = false      -- <true|false> highlight the current line?
o.expandtab = true        -- <true | false> convert tabs to spaces?
o.fileencoding = "utf-8"  -- <fileencodings> file-content encoding for the current buffer
o.foldcolumn = "1"        -- <string> 'auto' or number of columns to use for the fold column
o.foldenable = false      -- <true|false> don't start files folded; enable with zi; wait for https://github.com/neovim/neovim/pull/17446
o.foldlevelstart = 99     -- <int> using ufo provider need a large value, feel free to decrease the value
o.history = 500           -- <number> a history of ":" and search commands (max 10000)
o.hlsearch = true         -- <boolean> highlight all matches on previous search pattern
o.ignorecase = false      -- <boolean> ignore case in search patterns
o.laststatus = 3          -- {0,1,2,3} should the last window will have a status line? See `:h laststatus`
o.lazyredraw = true       -- <boolean> redraw screen while running macros? (true = faster)
o.list = true             -- <boolean> show some invisible characters (tabs, eol, etc.)
o.mouse = ""              -- <string> enable mouse support in which situations? See `:h 'mouse'`
o.number = true           -- <boolean> print the line number in front of each line?
o.path = ".,**"           -- <string> search paths. See `:h 'path'` and `:h starstar-wildcard`
o.relativenumber = true   -- <boolean> show relative line numbers?
o.scrolloff = 3           -- <number> minimum number of screen lines to keep above and below the cursor
o.shiftwidth = 2          -- <number> the number of spaces inserted for each indentation
o.shortmess = o.shortmess + "c" -- prevent "pattern not found" messages
o.showmode = false        -- <boolean> show the mode? (redundant if mode is built into the statusline)
o.sidescrolloff = 5       -- <number> the minimal number of columns to scroll horizontally
o.signcolumn = "yes"      -- <string> in {auto, no, yes, 1-9} - "yes" prevents gutter opening and closing spastically
o.smartcase = true        -- <boolean> override the 'ignorecase' option if the search pattern contains upper case characters?
o.smartindent = true      -- <boolean> make indenting smarter again?
o.spelllang = lang or "en_us" -- <string> language(s) to use for spell checking
o.splitbelow = true       -- <boolean> force all horizontal splits to go below current window?
o.splitright = true       -- <boolean> force all vertical splits to go to the right of current window?
o.swapfile = true         -- <boolean> enable/disable swap file creation?
o.tabstop = 2             -- <number> default: 8 - how many columns does a tab counts for?
o.termguicolors = true    -- <boolean> enable 24-bit RGB color in the TUI?
o.timeoutlen = 400        -- <number> time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0         -- <number> time in milliseconds to wait for a key code sequence to complete
o.undofile = true         -- <boolean> enable/disable undo file creation?
o.updatetime = 1000       -- <number> if nothing is typed after this many milliseconds the swap file will be written to disk
o.wildignorecase = true   -- <boolean> ignore setcase when completing file names and directories?
o.wildmode = "full"       -- <string> how to complete file names and directories
o.wrap = false            -- <boolean> wrap lines at the screen edge?
wo.foldexpr = "nvim_treesitter#foldexpr()" -- foldexpr for treesitter. See `:h fold-expr` and `:h nvim_treesitter#foldexpr()`
wo.foldmethod = "expr"    -- <string> foldmethod to use. See `:h foldmethod`

return M
