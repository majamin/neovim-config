------------------------- LAZY PLUGIN MANAGER ---------------------------------

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  local lazy_url = "https://github.com/folke/lazy.nvim"
  -- stylua: ignore start
  vim.fn.system({ "git", "clone", "--filter=blob:none", lazy_url, "--branch=stable", lazypath, })
  -- stylua: ignore stop
end

------------------------- USER OPTIONS ----------------------------------------

local o = vim.opt
local wo = vim.wo
local g = vim.g

g.mapleader = ";"
g.maplocalleader = ";"

-- stylua: ignore start
g.have_nerd_font = true         -- set to false if you don't have a nerd font
o.backspace = ""                -- influences the working of <BS>, etc. see `:h 'backspace'`
o.backup = false                -- <true|false> make a backup before overwriting a file?
o.breakindent = true            -- <true|false> Will every wrapped line continue visually indented?
o.clipboard = "unnamedplus"     -- <string> set clipboard mode - see `:h 'clipboard'`
o.cmdheight = 1                 -- <int> space for displaying messages/commands?
o.completeopt = { "menu", "menuone", "noselect", "noinsert" } -- options for Insert mode completion
o.conceallevel = 3              -- {0,1,2,3} Determine how text with "conceal" is shown
o.cursorline = true             -- <true|false> highlight the current line?
o.expandtab = true              -- <true | false> convert tabs to spaces?
o.fileencoding = "utf-8"        -- <fileencodings> file-content encoding for the current buffer
o.fillchars = { fold = "·" }    -- see `:h 'fillchars'`
o.foldcolumn = "0"              -- <string> 'auto' or number of columns to use for the fold column
o.foldenable = false            -- <true|false> all folds closed on buffer open? (zi to toggle)
o.foldtext = "v:lua.myfolds()"  -- see lua/user/funs.lua
o.history = 500                 -- <number> a history of ":" and search commands (max 10000)
o.hlsearch = true               -- <boolean> highlight all matches on previous search pattern
o.ignorecase = false            -- <boolean> ignore case in search patterns
o.laststatus = 3                -- {0,1,2,3} should the last window will have a status line? See `:h laststatus`
o.lazyredraw = true             -- <boolean> redraw screen while running macros? (true = faster)
o.list = true                   -- <boolean> show some invisible characters (tabs, eol, etc.)
o.mouse = ""                    -- <string> enable mouse support in which situations? See `:h 'mouse'`
o.number = true                 -- <boolean> print the line number in front of each line?
o.path = ".,**"                 -- <string> search paths. See `:h 'path'` and `:h starstar-wildcard`
o.relativenumber = true         -- <boolean> show relative line numbers?
o.rtp:prepend(lazypath)         -- add lazy to rtp
o.scrolloff = 3                 -- <number> minimum number of screen lines to keep above and below the cursor
o.shiftwidth = 2                -- <number> the number of spaces inserted for each indentation
o.shortmess = o.shortmess + "c" -- prevent "pattern not found" messages
o.showmode = false              -- <boolean> show the mode? (redundant if mode is built into the statusline)
o.sidescrolloff = 5             -- <number> the minimal number of columns to scroll horizontally
o.signcolumn = "yes"            -- <string> in {auto, no, yes, 1-9} - "yes" prevents gutter opening and closing spastically
o.smartcase = true              -- <boolean> override the 'ignorecase' option if the search pattern contains upper case characters?
o.smartindent = true            -- <boolean> make indenting smarter again?
o.spelllang = "en_ca"           -- <string> language(s) to use for spell checking
o.splitbelow = true             -- <boolean> force all horizontal splits to go below current window?
o.splitright = true             -- <boolean> force all vertical splits to go to the right of current window?
o.swapfile = true               -- <boolean> enable/disable swap file creation?
o.tabstop = 2                   -- <number> default: 8 - how many columns does a tab counts for?
o.termguicolors = true          -- <boolean> enable 24-bit RGB color in the TUI?
o.timeoutlen = 400              -- <number> time to wait for a mapped sequence to complete (in milliseconds)
o.ttimeoutlen = 0               -- <number> time in milliseconds to wait for a key code sequence to complete
o.undofile = true               -- <boolean> enable/disable undo file creation?
o.updatetime = 1000             -- <number> if nothing is typed after this many milliseconds the swap file will be written to disk
o.wildignorecase = true         -- <boolean> ignore setcase when completing file names and directories?
o.wildmode = "full"             -- <string> how to complete file names and directories
o.wrap = false                  -- <boolean> wrap lines at the screen edge?
wo.foldexpr =
"nvim_treesitter#foldexpr()"    -- foldexpr for treesitter. See `:h fold-expr` and `:h nvim_treesitter#foldexpr()`
wo.foldmethod = "expr"          -- <string> foldmethod to use. See `:h foldmethod`
-- stylua: ignore end

local non_plugin_maps = {
  -- stylua: ignore start
  { "<Esc>", "<cmd>nohlsearch<CR>" },
  { "<F2>", function() vim.cmd(":wa|mksession!") end, desc = "Save session and files", },
  { "<F3>", function() vim.cmd(":so Session.vim") end, desc = "Load session", },
  { "<F4>", ":setlocal spell!<CR>", desc = "Toggle spellcheck" },
  { "<TAB>", "<cmd>bn<CR>" },
  { "<S-TAB>", "<cmd>bp<CR>" },
  { "<C-w>b", "<cmd>bdelete<CR>", desc = "Close buffer" },
  { "<leader>h", ":help ", desc = "Help topics", icon = "󰞋", silent = false },
  { "<leader>b", ":buffer ", desc = "Buffers", icon = "", silent = false },
  { "<leader>f", ":find ", desc = "Files", icon = "", silent = false },
  { "<leader>g", ":Grep ", desc = "Grep", icon = "", silent = false },
  { "<leader>w", "<cmd>Vex<CR>", desc = "Browse files", icon = "" },
  { "<leader>q", vim.diagnostic.setloclist, desc = "Diagnostics", icon = "", },
  -- stylua: ignore start
}

-- define your installed LSP servers here
local servers = {
  lua_ls = {
    settings = {
      Lua = {
        runtime = {
          version = "LuaJIT",
        },
        workspace = {
          checkThirdParty = false,
          library = {
            vim.env.VIMRUNTIME,
            "${3rd}/love2d/library",
          },
        },
      },
    },
  },
  rust_analyzer = {},
  ts_ls = {},
  tailwindcss = {},
  svelte = {},
  cssls = {},
  pyright = {},
}

-- define your installed formatters here
local prettier = { "prettierd", "prettier", stop_after_first = true }
local formatters_by_ft = {
  bash = { "shfmt" },
  lua = { "stylua" },
  javascript = prettier,
  javascriptreact = prettier,
  typescript = prettier,
  typescriptreact = prettier,
  svelte = prettier,
  python = { "black" },
  vue = prettier,
  ["*"] = { "codespell" }, -- always run
  ["_"] = { "trim_whitespace" },
}

------------------------- HELPERS ---------------------------------------------

vim.cmd("command! -nargs=+ Grep execute 'silent grep! <args>' | copen")

-- Custom fold
function _G.myfolds()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return line .. " ·········· " .. line_count .. " lines "
end

------------------------- LOAD PLUGINS ----------------------------------------

require("lazy").setup({
  spec = {
    "tpope/vim-sleuth", --- https://github.com/tpope/vim-sleuth
    "tpope/vim-fugitive", --- https://github.com/tpope/vim-fugitive
    "tpope/vim-surround", --- https://github.com/tpope/vim-surround
    { --- https://github.com/folke/tokyonight.nvim
      "folke/tokyonight.nvim",
      priority = 1000,
      config = function()
        vim.cmd("colorscheme tokyonight")
      end,
    },
    { --- https://github.com/echasnovski/mini.statusline
      "echasnovski/mini.statusline",
      config = function()
        local statusline = require("mini.statusline")
        statusline.setup({ use_icons = vim.g.have_nerd_font })
        statusline.section_location = function()
          return "%2l:%-2v"
        end
      end,
    },
    {
      "echasnovski/mini.tabline", -- https://github.com/echasnovski/mini.tabline
      opts = {},
      event = "VeryLazy",
      version = "*",
    },
    { --- https://github.com/echasnovski/mini.indentscope
      "echasnovski/mini.indentscope",
      config = function()
        require("mini.indentscope").setup({
          -- stylua: ignore start
          draw = { delay = 0, animation = function() return 0 end },
          symbol = "░",
          -- stylua: ignore end
        })
        vim.api.nvim_set_hl(0, "MiniIndentscopeSymbol", { link = "NonText" })
      end,
    },
    { --- https://github.com/windwp/nvim-autopairs
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = true,
    },
    { --- https://github.com/lewis6991/gitsigns.nvim
      "lewis6991/gitsigns.nvim",
      config = true,
    },
    { --- https://github.com/folke/lazydev.nvim
      "folke/lazydev.nvim",
      event = { "BufReadPost", "BufNewFile" },
      ft = "lua", -- only load on lua files
      opts = {
        library = {
          { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        },
      },
    },
    { --- https://github.com/saghen/blink.cmp
      "saghen/blink.cmp",
      dependencies = "rafamadriz/friendly-snippets",
      version = "*",
      opts = {
        completion = {
          ghost_text = { enabled = true },
          menu = {
            border = "single",
            auto_show = function(ctx) -- don't auto show except for cmdline and path
              return ctx.mode == "cmdline" or ctx.mode == "path"
            end,
          },
          documentation = { auto_show = true, window = { border = "single" } },
        },
        signature = { enabled = true, window = { border = "single" } },
        keymap = {
          preset = "super-tab",
          ["<C-n>"] = { "show", "select_next", "fallback" },
          cmdline = {
            preset = "super-tab",
            ["<C-y>"] = { "accept", "fallback" }, -- accept but no confirm
            ["<TAB>"] = { -- accepts and confirms
              function(cmp)
                cmp.accept({
                  callback = function()
                    vim.api.nvim_feedkeys("\n", "n", true)
                  end,
                })
              end,
              "fallback",
            },
          },
        },
        appearance = {
          -- use_nvim_cmp_as_default = true, -- will deprecate in future releases
          nerd_font_variant = "mono",
        },
        sources = {
          default = { "lazydev", "lsp", "path", "snippets", "buffer" },
          providers = {
            lazydev = {
              name = "LazyDev",
              module = "lazydev.integrations.blink",
              score_offset = 100,
            },
            path = { opts = { show_hidden_files_by_default = true } },
          },
        },
      },
    },
    { --- https://github.com/neovim/nvim-lspconfig
      "neovim/nvim-lspconfig",
      dependencies = { "saghen/blink.cmp" },
      event = { "BufReadPost", "BufNewFile" },
      cmd = { "LspInfo", "LspInstall", "LspUninstall" },
      opts = {
        servers = servers,
      },
      config = function(_, opts)
        local lspconfig = require("lspconfig")

        vim.api.nvim_create_autocmd("LspAttach", {
          group = vim.api.nvim_create_augroup(
            "user-lsp-attach",
            { clear = true }
          ),
          callback = function(event)
            local wk = require("which-key")
            wk.add({
              -- stylua: ignore start
              { "<leader>l",  group = "LSP", icon = "" },
              { "<leader>lr", vim.lsp.buf.rename,      desc = "LSP: Rename" },
              { "<leader>la", vim.lsp.buf.code_action, desc = "LSP: Code Action" },
              { "K",          vim.lsp.buf.hover,       desc = "LSP: Hover Documentation" },
              { "gd",         vim.lsp.buf.definition,  desc = "LSP: Goto Definition" },
              { "gD",         vim.lsp.buf.declaration, desc = "LSP: Goto Declaration" },
              -- stylua: ignore end
            })

            local client = vim.lsp.get_client_by_id(event.data.client_id)

            if
              client
              and client.server_capabilities.inlayHintProvider
              and vim.lsp.inlay_hint
            then
              vim.lsp.inlay_hint.enable()
            end
          end,
        })

        for server, config in pairs(opts.servers) do
          -- passing config.capabilities to blink.cmp merges with the capabilities in your
          -- `opts[server].capabilities, if you've defined it
          config.capabilities =
            require("blink.cmp").get_lsp_capabilities(config.capabilities)
          lspconfig[server].setup(config)
        end
      end,
    },
    { --- https://github.com/stevearc/conform.nvim
      "stevearc/conform.nvim",
      event = { "BufReadPost", "BufWritePre" },
      cmd = { "Format", "ConformInfo" },
      config = function()
        local conform = require("conform")
        ---@module "conform"
        ---@type conform.setupOpts
        local opts = {
          async = true,
          default_format_opts = {
            lsp_format = "fallback",
          },
          formatters_by_ft = formatters_by_ft,
          format_on_save = { timeout_ms = 200 },
          formatters = {
            shfmt = {
              prepend_args = { "-i", "2" },
            },
          },
        }

        local wk = require("which-key")
        wk.add({
          {
            "<leader><leader>",
            conform.format,
            desc = "Format buffer",
            icon = "",
          },
        })
        conform.setup(opts)
      end,
    },
    { --- https://github.com/windwp/nvim-ts-autotag
      "windwp/nvim-ts-autotag",
      event = { "BufReadPre", "BufNewFile" },
      config = function()
        require("nvim-ts-autotag").setup({
          opts = {
            enable_close = true,
            enable_rename = true,
            enable_close_on_slash = false,
          },
        })
      end,
    },
    { --- https://github.com/nvim-treesitter/nvim-treesitter
      "nvim-treesitter/nvim-treesitter",
      cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
      build = ":TSUpdate",
      event = {
        "BufReadPost",
        "BufNewFile",
      },
      config = function()
        local configs = require("nvim-treesitter.configs")
        configs.setup({
          incremental_selection = {
            enable = true,
            keymaps = {
              init_selection = " ",
              node_incremental = " ",
              scope_incremental = "gi",
              node_decremental = "g ",
            },
          },
          highlight = {
            enable = true,
            additional_vim_regex_highlighting = { "ruby" },
          },
          indent = { enable = true, disable = { "ruby" } },
        })
      end,
    },
    { --- https://github.com/folke/which-key.nvim
      "folke/which-key.nvim",
      config = function()
        local wk = require("which-key")
        wk.setup({
          preset = "helix",
          delay = 1400,
        })
        wk.add(non_plugin_maps)
      end,
    },
  },
  install = { colorscheme = { "slate" } },
  checker = { enabled = false },
})
