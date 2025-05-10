local non_plugin_maps = require("keys").non_plugin_maps
local has_words_before = require("funs").has_words_before
local formatters_by_ft = require("opts").formatters_by_ft

return {
  { --- https://cmp.saghen.dev
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    version = "1.*",
    opts = {
      keymap = { -- https://main.cmp.saghen.dev/recipes#emacs-behavior
        preset = "super-tab",
        -- ["<CR>"] = { "accept", "fallback" },
        ["<C-n>"] = { "select_next", "show", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
      },
      completion = {
        ghost_text = { enabled = true, show_with_menu = false },
        menu = { auto_show = false },
      },
      appearance = { nerd_font_variant = "Nerd Font Mono" },
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
      fuzzy = { implementation = "prefer_rust_with_warning" },
    },
    opts_extend = { "sources.default" },
  },
  { --- https://github.com/folke/tokyonight.nvim
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { "projekt0n/github-nvim-theme", name = "github-theme" },
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
  { --- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    event = {
      "BufReadPost",
      "BufNewFile",
    },
    config = function()
      vim.filetype.add({
        extension = { rasi = "rasi" },
        pattern = {
          [".*/waybar/config"] = "jsonc",
          [".*/mako/config"] = "dosini",
          [".*/kitty/*.conf"] = "bash",
          [".*/hypr/.*%.conf"] = "hyprlang",
        },
      })

      require("nvim-treesitter.install").prefer_git = true
      require("nvim-treesitter.configs").setup({
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = " ",
            node_incremental = " ",
            scope_incremental = "gi",
            node_decremental = "g ",
          },
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { "ruby" },
        },
        indent = { enable = true, disable = { "ruby" } },
      })
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
  { --- https://github.com/stevearc/oil.nvim
    "stevearc/oil.nvim",
    cmd = { "Oil" },
    opts = {},
  },
  { --- https://github.com/majamin/buffy.nvim
    -- dir = "~/.local/src/buffy.nvim",
    "majamin/buffy.nvim",
    opts = {},
  },
  { --- https://github.com/jpalardy/vim-slime
    "jpalardy/vim-slime",
    config = function()
      vim.cmd("let g:slime_target = 'tmux'")
    end,
  },
  { --- https://github.com/windwp/nvim-autopairs
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      enable_check_bracket_line = false, -- helps lisp-like langs
    },
  },
  { --- https://github.com/stevearc/oil.nvim
    "folke/snacks.nvim",
    ---@type snacks.Config
    opts = {
      picker = {},
      explorer = {},
    },
    keys = {
      -- stylua: ignore start
      { "<leader>f",  function () Snacks.picker.smart() end,                desc = "Smart Find Files", },
      { "<leader>g",  function () Snacks.picker.grep() end,                 desc = "Grep Files", },
      { "<leader>:",  function () Snacks.picker.command_history() end,      desc = "Command History", },
      { "<leader>o",  function () Snacks.picker.recent() end,               desc = "Recent", },
      { "<leader>h",  function () Snacks.picker.help() end,                 desc = "Help Pages", },
      { "<leader>k",  function () Snacks.picker.keymaps() end,              desc = "Keymaps", },
      { "<leader>l",  function () Snacks.picker.loclist() end,              desc = "Location List", },
      { "gd",         function () Snacks.picker.lsp_definitions() end,      desc = "Goto Definition", },
      { "gD",         function () Snacks.picker.lsp_declarations() end,     desc = "Goto Declaration", },
      { "gr",         function () Snacks.picker.lsp_references() end,       desc = "References",             nowait = true, },
      { "gI",         function () Snacks.picker.lsp_implementations() end,  desc = "Goto Implementation", },
      { "gy",         function () Snacks.picker.lsp_type_definitions() end, desc = "Goto T[y]pe Definition", },
      { "<leader>ss", function () Snacks.picker.lsp_symbols() end,          desc = "LSP Symbols", },
      { "<leader>sS", function () Snacks.picker.lsp_workspace_symbols() end, desc = "LSP Workspace Symbols", },
      -- stylua: ignore end
    },
  },
  "tpope/vim-sleuth", --- https://github.com/tpope/vim-sleuth
  "tpope/vim-fugitive", --- https://github.com/tpope/vim-fugitive
  "tpope/vim-surround", --- https://github.com/tpope/vim-surround
}
