local non_plugin_maps = require("keys").non_plugin_maps
local special_formatters = require("opts").special_formatters
local formatters_by_ft = require("opts").formatters_by_ft

return {
  { --- https://github.com/neovim/nvim-lspconfig
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "saghen/blink.cmp",
      event = "InsertEnter",
    },
    config = function()
      local wk = require("which-key")
      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
        callback = function(event)
          local Snacks = require("snacks")

          -- stylua: ignore start
          wk.add({
            { "gd",  Snacks.picker.lsp_definitions,       desc = "Goto Definition"      }, -- keeping to stay consistent with historical binds
            { "gD",  Snacks.picker.lsp_declarations,      desc = "Goto Declaration"     }, -- keeping to stay consistent with historical binds
            { "gla", vim.lsp.buf.code_action,             desc = "Code actions"         },
            { "gli", Snacks.picker.lsp_implementations,   desc = "Goto Implementation"  },
            { "gln", vim.lsp.buf.rename,                  desc = "Rename"               },
            { "glr", Snacks.picker.lsp_references,        desc = "References"           },
            { "gls", Snacks.picker.lsp_symbols,           desc = "Symbols"              },
            { "glS", Snacks.picker.lsp_workspace_symbols, desc = "Workspace Symbols"    },
            { "glt", Snacks.picker.lsp_type_definitions,  desc = "Goto Type Definition" },
          })
          -- stylua: ignore end

          -- Highlight word under cursor
          -- Adapted from kickstart.nvim
          -- Improved with Claude Sonnet 4.6: highlighting _stays_ if you remain on the same object
          local client = vim.lsp.get_client_by_id(event.data.client_id)
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
            local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = true })
            local hl_tick = 0

            local function cursor_in_refs()
              local ns = vim.api.nvim_get_namespaces()["nvim.lsp.references"]
              if not ns then return false end
              local pos = vim.api.nvim_win_get_cursor(0)
              local row, col = pos[1] - 1, pos[2]
              for _, mark in ipairs(
                vim.api.nvim_buf_get_extmarks(event.buf, ns, { row, 0 }, { row, -1 }, { details = true })
              ) do
                local sc, ec = mark[3], mark[4].end_col
                if sc <= col and (ec == nil or col < ec) then return true end
              end
              return false
            end

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = function()
                hl_tick = hl_tick + 1
                local tick = hl_tick
                local params = vim.lsp.util.make_position_params()
                vim.lsp.buf_request(event.buf, "textDocument/documentHighlight", params, function(err, result, ctx)
                  if err or not result or hl_tick ~= tick then return end
                  vim.lsp.buf.clear_references()
                  local c = vim.lsp.get_client_by_id(ctx.client_id)
                  if c then vim.lsp.util.buf_highlight_references(event.buf, result, c.offset_encoding) end
                end)
              end,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
              buffer = event.buf,
              group = highlight_augroup,
              callback = function()
                if cursor_in_refs() then return end
                hl_tick = hl_tick + 1
                vim.lsp.buf.clear_references()
              end,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
              group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
              callback = function(ev)
                vim.lsp.buf.clear_references()
                vim.api.nvim_clear_autocmds({
                  group = "user-lsp-highlight",
                  buffer = ev.buf,
                })
              end,
            })
          end

          -- Toggle inlay hints
          if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
            wk.add({
              "glh",
              function()
                vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
              end,
              desc = "Toggle Inlay [H]ints",
            })
          end
        end,
      })

      local capabilities = require("blink.cmp").get_lsp_capabilities()
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- scan lsp/ and enable servers by named configs
      local lsp_configs = {}
      local lsp_dir = vim.fn.stdpath("config") .. "/lsp"

      for name, type in vim.fs.dir(lsp_dir) do
        if type == "file" and name:match("%.lua$") then
          local server_name = name:sub(1, -5)
          lsp_configs[server_name] = true
        end
      end

      -- Enable all found servers
      for server in pairs(lsp_configs) do
        pcall(vim.lsp.enable, server)
      end
    end,
  },
  { --- https://cmp.saghen.dev
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    event = "BufRead",
    -- build = "cargo build --release",
    version = "*",
    config = function()
      require("blink.cmp").setup({
        keymap = {
          preset = "super-tab",
          ["<C-n>"] = {
            "show",
            "select_next",
            "fallback",
          },
          ["<Tab>"] = { "select_and_accept", "fallback" },
          ["<C-h>"] = { "snippet_backward", "fallback" },
          ["<C-l>"] = { "snippet_forward", "fallback" },
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
      })

      -- Workaround: Disable Neovim's intrusive default Tab/S-Tab snippet navigation
      --
      -- CONTEXT: Since Neovim 0.10, vim.snippet.expand() automatically creates
      -- buffer-local Tab/S-Tab mappings for snippet navigation. This overrides
      -- user configurations and breaks custom Tab workflows (like completion menu
      -- navigation). There is NO built-in way to disable this behavior.
      --
      -- ISSUE HISTORY:
      -- - https://github.com/neovim/neovim/issues/30198
      --   Issue requesting configurability - closed as "wontfix"
      -- - https://github.com/neovim/neovim/pull/30430
      --   PR attempting to fix the issue - closed without merging
      --
      -- MAINTAINER POSITION: Neovim maintainers acknowledge this is problematic
      -- but refuse to implement a configuration option, citing architectural
      -- limitations and concerns about breaking other plugins.
      --
      -- THIS WORKAROUND: Aggressively override Tab/S-Tab on every buffer and
      -- every InsertEnter to prevent vim.snippet from hijacking these keys.
      -- We use <C-h>/<C-l> for snippet navigation instead (configured above).

      local function disable_snippet_tab_mappings()
        -- Only override in select mode (snippet placeholders), not insert mode
        -- This allows blink.cmp to handle Tab for completion in insert mode
        vim.keymap.set("s", "<Tab>", "<Tab>", {
          buffer = 0,
          noremap = true,
          silent = true,
        })
        vim.keymap.set("s", "<S-Tab>", "<S-Tab>", {
          buffer = 0,
          noremap = true,
          silent = true,
        })
      end

      vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
        callback = disable_snippet_tab_mappings,
      })

      vim.api.nvim_create_autocmd("InsertEnter", {
        callback = disable_snippet_tab_mappings,
      })
    end,
  },
  { --- https://github.com/j-hui/fidget.nvim
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = { notification = { override_vim_notify = true } },
  },
  { --- https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
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

      ts.install(require("opts").treesitter_ensure_installed)

      local available = ts.get_available()

      local function treesitter_try_attach(buf, language)
        if not vim.treesitter.language.add(language) then
          return
        end
        vim.treesitter.start(buf, language)
        if vim.treesitter.query.get(language, "indents") ~= nil then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          local installed = ts.get_installed("parsers")

          if vim.tbl_contains(installed, language) then
            treesitter_try_attach(buf, language)
          elseif vim.tbl_contains(available, language) then
            ts.install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
          else
            treesitter_try_attach(buf, language)
          end
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
        "<leader>=",
        function()
          local conform = require("conform")
          conform.format({
            async = true,
            lsp_format = "fallback",
          }, function()
            conform.format({
              async = true,
              formatters = { "trim_whitespace" },
            })
          end)
        end,
        mode = "",
        desc = "Format buffer",
      },
    },
    opts = {
      notify_on_error = false,
      format_on_save = false,
      formatters = special_formatters,
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
  { --- https://github.com/majamin/litmus.nvim
    -- "majamin/litmus.nvim",
    dir = "/home/marian/.local/src/litmus.nvim",
    opts = {},
  },
  { --- https://github.com/majamin/buffy.nvim
    "majamin/buffy.nvim",
    opts = {},
    keys = {
      {
        "<Tab>",
        function()
          require("buffy").next()
        end,
        desc = "Next buffer",
      },
      {
        "<S-Tab>",
        function()
          require("buffy").prev()
        end,
        desc = "Previous buffer",
      },
    },
  },
  { --- https://github.com/jpalardy/vim-slime
    "jpalardy/vim-slime",
    keys = {
      { "<C-c><C-c>", desc = "Slime send" },
    },
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
  {
    "folke/zen-mode.nvim",
    opts = {
      window = {
        width = 90,
        options = {
          number = false,
          relativenumber = false,
          signcolumn = "no",
          cursorline = false,
          foldcolumn = "0",
        },
      },
      plugins = {
        options = {
          laststatus = 0, -- hide statusline
          ruler = false,
          showcmd = false,
        },
        twilight = { enabled = false },
        gitsigns = { enabled = false },
      },
    },
  },
  { --- https://github.com/folke/snacks.nvim
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
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
    event = "BufReadPre",
    opts = {},
  },
  "tpope/vim-fugitive", --- https://github.com/tpope/vim-fugitive
  "tpope/vim-surround", --- https://github.com/tpope/vim-surround
  {
    "mbbill/undotree",
    config = function()
      require("which-key")
    end,
  }, --- https://github.com/mbbill/undotree
  { --- https://github.com/folke/todo-comments.nvim
    "folke/todo-comments.nvim",
    opts = {},
  },
  { --- https://github.com/folke/flash.nvim
    "folke/flash.nvim",
    event = "VeryLazy",
    ---@type Flash.Config
    opts = {
      jump = {
        nohlsearch = true,
      },
    },
    keys = {
      {
        "<CR>",
        mode = { "n", "x", "o" },
        function()
          require("flash").jump()
        end,
        desc = "Flash",
      },
    },
  },
  { --- https://github.com/nvim-mini/mini.nvim
    "echasnovski/mini.nvim",
    event = "VeryLazy",
    dependencies = {
      { "lewis6991/gitsigns.nvim", opts = { numhl = true, signcolumn = false }, event = "VeryLazy" },
    },
    config = function()
      local statusline = require("mini.statusline")
      statusline.setup({ use_icons = vim.g.have_nerd_font })
      ---@diagnostic disable-next-line: duplicate-set-field
      statusline.section_location = function()
        return "%2l:%-2v"
      end
      local indentscope = require("mini.indentscope")
      indentscope.setup({
        draw = {
          animation = function()
            return 0
          end,
        },
        symbol = "░",
      })
    end,
  },
  {
    "norcalli/nvim-colorizer.lua",
    opts = {},
    keys = {
      {
        "<leader>c",
        ":ColorizerToggle<CR>",
        mode = "",
        desc = "Colorize hex colors",
      },
    },
  },
  "mechatroner/rainbow_csv",
}
