local non_plugin_maps = require("keys").non_plugin_maps
local formatters_by_ft = require("opts").formatters_by_ft

return {
  { --- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
    },
    config = function()
      local wk = require("which-key")
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local Snacks = require("snacks")
          local map = function(keys, func, desc, mode)
            mode = mode or "n"
            vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
          end

          -- stylua: ignore start
          wk.add({ "gr", group = "LSP references" })
          map("gD", function () Snacks.picker.lsp_declarations() end, "Goto Declaration")
          map("gI", function () Snacks.picker.lsp_implementations() end, "Goto Implementation")
          map("gS", function () Snacks.picker.lsp_workspace_symbols() end, "Workspace Symbols")
          map("gd", function () Snacks.picker.lsp_definitions() end, "Goto Definition")
          map("gs", function () Snacks.picker.lsp_symbols() end, "Symbols")
          map("gt", function () Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
          map("gra", function () vim.lsp.buf.code_action() end, "Code actions")
          map("gri", function () vim.lsp.buf.implementation() end, "Implementations")
          map("grn", function () vim.lsp.buf.rename() end, "Rename")
          map("grr", function () Snacks.picker.lsp_references() end, "References")
          -- stylua: ignore end

          -- Toggle inlay hints
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            map("<leader>lh", function()
              vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
            end, "Toggle Inlay Hints")
          end
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- scan lsp/ and enable servers by named configs
      local contents = vim.uv.fs_scandir(vim.fn.stdpath("config") .. "/lsp")
      while contents do
        local file = select(1, vim.uv.fs_scandir_next(contents))
        if not file then
          break
        end
        if file:sub(-4) == ".lua" then
          vim.lsp.enable(file:sub(1, -5))
        end
      end
    end,
  },
  { --- https://cmp.saghen.dev
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets", "saghen/blink.cmp" },
    event = "VimEnter",
    version = "*",
    opts = {
      keymap = { -- https://main.cmp.saghen.dev/recipes#emacs-behavior
        preset = "super-tab",
        ["<C-n>"] = { "show", "select_next", "fallback" },
        ["<C-p>"] = { "select_prev", "fallback" },
        ["<C-y>"] = { "accept", "fallback" },
      },
      cmdline = {
        preset = "cmdline",
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
        },
      },
      fuzzy = { implementation = "prefer_rust_with_warning" },
      signature = { enabled = true, trigger = { show_on_insert = false } },
    },
    opts_extend = { "sources.default" },
  },
  { --- https://github.com/folke/tokyonight.nvim
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = {},
  },
  { --- https://github.com/projekt0n/github-nvim-theme
    "projekt0n/github-nvim-theme",
    name = "github-theme",
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
  { --- https://github.com/folke/lazydev.nvim
    "folke/lazydev.nvim",
    ft = "lua", -- only load on lua files
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    main = "nvim-treesitter.configs", -- set main module
    branch = "master", -- TODO: switch to main soon
    lazy = false,
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "diff",
        "html",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "query",
        "vim",
        "vimdoc",
      },
      auto_install = true,
      highlight = {
        enable = true,
        additional_vim_regex_highlighting = { "ruby" }, -- depends on vim's regex
      },
      indent = { enable = true, disable = { "ruby" } },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = " ",
          node_incremental = " ",
          scope_incremental = "gi",
          node_decremental = "g ",
        },
      },
    },
  },
  { --- https://github.com/stevearc/conform.nvim
    "stevearc/conform.nvim",
    event = { "BufWritePre" },
    cmd = { "ConformInfo" },
    keys = {
      {
        "<leader><leader>",
        function()
          require("conform").format({ async = true, lsp_format = "fallback" })
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = function(bufnr)
        -- Disable "format_on_save lsp_fallback" for languages that don't
        -- have a well standardized coding style. You can add additional
        -- languages here or re-enable it for the disabled ones.
        local disable_filetypes = { c = true, cpp = true }
        if disable_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 500,
            lsp_format = "fallback",
          }
        end
      end,
      formatters_by_ft = formatters_by_ft,
    },
  },
  { --- https://github.com/stevearc/oil.nvim
    "stevearc/oil.nvim", -- https://github.com/stevearc/oil.nvim/releases
    cmd = { "Oil" },
    config = function()
      -- https://github.com/stevearc/oil.nvim/pull/240
      local permission_hlgroups = {
        ["-"] = "NonText",
        ["r"] = "DiagnosticSignWarn",
        ["w"] = "DiagnosticSignError",
        ["x"] = "DiagnosticSignOk",
      }
      require("oil").setup({
        columns = {
          {
            "permissions",
            highlight = function(permission_str)
              local hls = {}
              for i = 1, #permission_str do
                local char = permission_str:sub(i, i)
                table.insert(hls, { permission_hlgroups[char], i - 1, i })
              end
              return hls
            end,
          },
          { "size", highlight = "Special" },
          { "mtime", highlight = "Number" },
          {
            "icon",
            default_file = "",
            directory = "",
            add_padding = false,
          },
        },
        skip_confirm_for_simple_edits = true,
        win_options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          foldcolumn = "0",
          statuscolumn = "",
        },
        keymaps = {
          ["-"] = { "actions.close", mode = "n" },
          ["<BS>"] = { "actions.parent", mode = "n" },
        },
      })
    end,
    keys = {
      {
        "-",
        "<cmd>:Oil<CR>",
        { "n" },
        { desc = "Open parent directory" },
      },
    },
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
  { --- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
    lazy = false,
    priority = 1000,
    ---@type snacks.Config
    opts = {
      picker = {},
      explorer = {},
    },
    keys = {
      -- stylua: ignore start
      { "<leader>f", function () Snacks.picker.smart() end,           desc = "Smart Find Files", },
      { "<leader>g", function () Snacks.picker.grep() end,            desc = "Grep Files", },
      { "<leader>:", function () Snacks.picker.command_history() end, desc = "Command History", },
      { "<leader>o", function () Snacks.picker.recent() end,          desc = "Recent", },
      { "<leader>h", function () Snacks.picker.help() end,            desc = "Help Pages", },
      { "<leader>k", function () Snacks.picker.keymaps() end,         desc = "Keymaps", },
      { "<leader>l", function () Snacks.picker.loclist() end,         desc = "Location List", },
      -- stylua: ignore end
    },
  },
  "tpope/vim-sleuth", --- https://github.com/tpope/vim-sleuth
  "tpope/vim-fugitive", --- https://github.com/tpope/vim-fugitive
  "tpope/vim-surround", --- https://github.com/tpope/vim-surround
  {
    "bngarren/checkmate.nvim",
    ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {},
  },
}
