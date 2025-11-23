local non_plugin_maps = require("keys").non_plugin_maps
local formatters_by_ft = require("opts").formatters_by_ft
local disable_formatter_filetypes = require("opts").disable_formatter_filetypes

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
            vim.keymap.set(
              mode,
              keys,
              func,
              { buffer = event.buf, desc = "LSP: " .. desc }
            )
          end

          -- stylua: ignore start
          wk.add({ "gl", group = "LSP" })
          map("gD", function () Snacks.picker.lsp_declarations() end, "Goto Declaration")
          map("gI", function () Snacks.picker.lsp_implementations() end, "Goto Implementation")
          map("gS", function () Snacks.picker.lsp_workspace_symbols() end, "Workspace Symbols")
          map("gd", function () Snacks.picker.lsp_definitions() end, "Goto Definition")
          map("gs", function () Snacks.picker.lsp_symbols() end, "Symbols")
          map("gt", function () Snacks.picker.lsp_type_definitions() end, "Goto Type Definition")
          map("gla", function () vim.lsp.buf.code_action() end, "Code actions")
          map("gli", function () vim.lsp.buf.implementation() end, "Implementations")
          map("gln", function () vim.lsp.buf.rename() end, "Rename")
          map("glr", function () Snacks.picker.lsp_references() end, "References")
          -- stylua: ignore end

          -- Toggle inlay hints
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if
            client
            and client:supports_method(
              vim.lsp.protocol.Methods.textDocument_inlayHint,
              event.buf
            )
          then
            map("glh", function()
              vim.lsp.inlay_hint.enable(
                not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
              )
            end, "Toggle Inlay [H]ints")
          end
        end,
      })

      -- shamelessly taken from kickstart
      vim.diagnostic.config({
        severity_sort = true,
        float = { border = "rounded", source = "if_many" },
        underline = { severity = vim.diagnostic.severity.ERROR },
        signs = vim.g.have_nerd_font and {
          text = {
            [vim.diagnostic.severity.ERROR] = "● ",
            [vim.diagnostic.severity.WARN] = "● ",
            [vim.diagnostic.severity.INFO] = "● ",
            [vim.diagnostic.severity.HINT] = "󰌶 ",
          },
        } or {},
        virtual_text = {
          spacing = 4,
          prefix = function(diagnostic)
            local icons = {
              [vim.diagnostic.severity.ERROR] = "✘",
              [vim.diagnostic.severity.WARN] = "▲",
              [vim.diagnostic.severity.INFO] = "●",
              [vim.diagnostic.severity.HINT] = "◆",
            }
            return icons[diagnostic.severity] or "●"
          end,
        },
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- scan lsp/ and enable servers by named configs
      local lsp_dir = vim.fn.stdpath("config") .. "/lsp"
      local contents, err = vim.uv.fs_scandir(lsp_dir)
      if not contents then
        if err ~= "ENOENT" then -- ignore if directory doesn't exist
          vim.notify(
            "Failed to scan LSP directory: " .. (err or "unknown error"),
            vim.log.levels.WARN
          )
        end
        return
      end
      while true do
        local file = vim.uv.fs_scandir_next(contents)
        if not file then
          break
        end
        if file:sub(-4) == ".lua" then
          local ok, result = pcall(vim.lsp.enable, file:sub(1, -5))
          if not ok then
            vim.notify(
              "Failed to enable LSP server from " .. file .. ": " .. result,
              vim.log.levels.ERROR
            )
          end
        end
      end
    end,
  },
  { --- https://cmp.saghen.dev
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "BufRead",
    build = "cargo build --release",
    -- version = "*",
    opts = {
      keymap = {
        preset = "super-tab",
        ["<C-n>"] = {
          "show",
          "select_next",
          "fallback",
        },
      },
      completion = {
        menu = { enabled = true },
        list = {
          selection = { preselect = false },
          cycle = { from_top = false },
        },
        documentation = { auto_show = true },
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
      signature = { enabled = true, trigger = { show_on_insert = true } },
    },
    opts_extend = { "sources.default" },
  },
  { "j-hui/fidget.nvim", opts = {} },
  { --- https://github.com/folke/tokyonight.nvim
    "folke/tokyonight.nvim",
    lazy = false,
    priority = 1000,
    opts = { transparent = true },
  },
  { --- https://github.com/projekt0n/github-nvim-theme
    "projekt0n/github-nvim-theme",
    name = "github-theme",
    opts = {
      options = {
        -- transparent = true,
      },
    },
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
    cmd = "LazyDev",
    opts = {
      library = {
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
        { path = "snacks.nvim", words = { "Snacks" } },
      },
    },
  },
  { --- https://github.com/nvim-treesitter/nvim-treesitter
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    branch = "main",
    build = ":TSUpdate",
    config = function()
      local ts = require("nvim-treesitter")
      local treesitter_ensure_installed =
        require("opts").treesitter_ensure_installed
      ts.install(treesitter_ensure_installed)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "*" },
        callback = function(ev)
          local ft = ev.match or vim.bo[ev.buf].filetype
          local exclude_patterns = {
            "snacks*",
            "oil",
          }
          -- quit if buffer is one of the excluded patterns
          for _, pat in ipairs(exclude_patterns) do
            if ft:match(pat) then
              return
            end
          end
          local ok, _ = pcall(vim.treesitter.start) -- enable for all files, but quietly on error
          if ok then
            return
          end

          local lang = (
            pcall(vim.treesitter.language.get_lang, ft)
            and vim.treesitter.language.get_lang(ft)
          ) or ft

          pcall(ts.install, lang)
          pcall(vim.treesitter.start, ev.buf)
        end,
      })
    end,
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
        if disable_formatter_filetypes[vim.bo[bufnr].filetype] then
          return nil
        else
          return {
            timeout_ms = 8500,
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
          ["q"] = { "actions.close", mode = "n" },
          ["-"] = { "actions.parent", mode = "n" },
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
  { --- https://github.com/NMAC427/guess-indent.nvim
    "NMAC427/guess-indent.nvim",
    opts = {},
  },
  "tpope/vim-fugitive", --- https://github.com/tpope/vim-fugitive
  "tpope/vim-surround", --- https://github.com/tpope/vim-surround
  { --- https://github.com/bngarren/checkmate.nvim
    "bngarren/checkmate.nvim",
    ft = "markdown", -- Lazy loads for Markdown files matching patterns in 'files'
    opts = {},
  },
  -- { --- https://github.com/lervag/vimtex
  --   "lervag/vimtex",
  --   ft = { "tex", "sty" },
  -- },
  { --- https://github.com/folke/zen-mode.nvim
    "folke/zen-mode.nvim",
    dependencies = {
      {
        "folke/twilight.nvim",
        opts = {},
      },
    },
    opts = {
      window = {
        width = 80,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
        },
      },
      plugins = {
        options = {
          enabled = true,
          showcmd = false,
          laststatus = 0,
          ruler = false,
        },
        tmux = { enabled = true },
        todo = { enabled = true },
      },
    },
  },
}
