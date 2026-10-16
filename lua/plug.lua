local non_plugin_maps = require("keys").non_plugin_maps
local special_formatters = require("opts").special_formatters
local formatters_by_ft = require("opts").formatters_by_ft
local treesitter_noinstall_noenable = require("opts").treesitter_noinstall_noenable

return {
  { --- https://github.com/neovim/nvim-lspconfig
    -- provides the server defaults (cmd, filetypes, root) for the stub files in lsp/
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
  },
  { --- https://cmp.saghen.dev
    "saghen/blink.cmp",
    dependencies = { "rafamadriz/friendly-snippets" },
    -- load before the first language server starts, so blink can add its capabilities
    event = { "BufReadPre", "BufNewFile" },
    -- build = "cargo build --release",
    version = "*",
    opts = {
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
    },
  },
  { --- https://github.com/j-hui/fidget.nvim
    "j-hui/fidget.nvim",
    event = "LspAttach",
    opts = { notification = { override_vim_notify = true } },
  },
  { --- https://github.com/rachartier/tiny-inline-diagnostic.nvim
    -- draws the inline diagnostic messages (virtual_text is off in opts.lua)
    "rachartier/tiny-inline-diagnostic.nvim",
    event = "LspAttach",
    priority = 1000,
    opts = {
      preset = "modern",
      -- keep messages on the error's own line, never drawn over the code below
      -- (softwrap = 0 stops long code lines pushing the message underneath; <C-w>d shows the full text)
      options = {
        overflow = { mode = "oneline" },
        show_diags_only_under_cursor = true,
        -- softwrap = 0,
        -- show_related = { enabled = false },
      },
    },
  },
  { --- https://github.com/folke/which-key.nvim
    "folke/which-key.nvim",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      wk.setup({
        preset = "helix",
        -- wait before showing the popup, except for the git maps under gh
        delay = function(ctx)
          return vim.startswith(ctx.keys, "gh") and 0 or 1400
        end,
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

      local available = {}
      for _, lang in ipairs(ts.get_available()) do
        available[lang] = true
      end

      local function treesitter_try_attach(buf, language)
        if not vim.api.nvim_buf_is_valid(buf) or not vim.treesitter.language.add(language) then
          return false
        end
        vim.treesitter.start(buf, language)
        if vim.treesitter.query.get(language, "indents") ~= nil then
          vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end
        return true
      end

      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf, filetype = args.buf, args.match
          if treesitter_noinstall_noenable[filetype] then
            return
          end
          local language = vim.treesitter.language.get_lang(filetype)
          if not language then
            return
          end

          -- attach if the parser is present, otherwise install it when nvim-treesitter knows it
          if not treesitter_try_attach(buf, language) and available[language] then
            ts.install(language):await(function()
              treesitter_try_attach(buf, language)
            end)
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
        ["x"] = "DiagnosticSignHint",
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
            default_file = "",
            directory = "",
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
      { "-", "<cmd>Oil<CR>", desc = "Browse files with Oil" },
    },
  },
  { --- https://github.com/majamin/litmus.nvim
    "majamin/litmus.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      -- colors/litmus.lua runs setup(), so only store the option here
      require("litmus").config.transparent = true
      vim.cmd.colorscheme("litmus")
    end,
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
    init = function()
      vim.g.slime_target = "tmux"
    end,
  },
  { --- https://github.com/windwp/nvim-autopairs
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
      enable_check_bracket_line = false, -- helps lisp-like langs
    },
  },
  { --- https://github.com/folke/zen-mode.nvim
    "folke/zen-mode.nvim",
    cmd = "ZenMode",
    opts = {
      window = {
        backdrop = 1,
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
    opts = {
      picker = {},
    },
    keys = {
      -- stylua: ignore start
      { "<leader>f", function () require("snacks").picker.smart() end,           desc = "Smart Find Files", },
      { "<leader>g", function () require("snacks").picker.grep() end,            desc = "Grep Files", },
      { "<leader>:", function () require("snacks").picker.command_history() end, desc = "Command History", },
      { "<leader>o", function () require("snacks").picker.recent() end,          desc = "Recent", },
      { "<leader>h", function () require("snacks").picker.help() end,            desc = "Help Pages", },
      { "<leader>k", function () require("snacks").picker.keymaps() end,         desc = "Keymaps", },
      { "<leader>l", function () require("snacks").picker.loclist() end,         desc = "Location List", },
      -- stylua: ignore end
    },
  },
  { --- https://github.com/NMAC427/guess-indent.nvim
    "NMAC427/guess-indent.nvim",
    event = "BufReadPre",
    opts = {},
  },
  { --- https://github.com/tpope/vim-fugitive
    "tpope/vim-fugitive",
    cmd = {
      "G",
      "Git",
      "Gdiffsplit",
      "Gvdiffsplit",
      "Gedit",
      "Gread",
      "Gwrite",
      "Ggrep",
      "Glgrep",
      "Gclog",
      "Gllog",
      "GMove",
      "GRename",
      "GDelete",
      "GRemove",
      "GBrowse",
    },
  },
  { --- https://github.com/folke/todo-comments.nvim
    "folke/todo-comments.nvim",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TodoQuickFix", "TodoLocList" },
    opts = {},
  },
  { --- https://github.com/folke/flash.nvim
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      jump = {
        nohlsearch = true,
      },
    },
    keys = {
      -- stylua: ignore start
      { "s", function() require("flash").jump() end,       mode = { "n", "x", "o" }, desc = "Flash jump" },
      -- visual S stays as mini.surround's "add surrounding"
      { "S", function() require("flash").treesitter() end, mode = { "n", "o" },      desc = "Flash select node" },
      { "r", function() require("flash").remote() end,     mode = "o",               desc = "Flash remote" },
      -- stylua: ignore end
    },
  },
  { --- https://github.com/lewis6991/gitsigns.nvim
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    opts = {
      numhl = true,
      signcolumn = false,
      -- Keymaps adapted from kickstart.nvim, under `gh` because <leader>h is the help picker
      on_attach = function(buf)
        local gitsigns = require("gitsigns")
        local function map(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buf = buf, desc = desc })
        end
        local function selected_lines()
          return { vim.fn.line("."), vim.fn.line("v") }
        end

        -- ]c and [c keep their builtin meaning in diff mode
        map("n", "]c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "]c", bang = true })
          else
            gitsigns.nav_hunk("next")
          end
        end, "Next git hunk")
        map("n", "[c", function()
          if vim.wo.diff then
            vim.cmd.normal({ "[c", bang = true })
          else
            gitsigns.nav_hunk("prev")
          end
        end, "Previous git hunk")

        -- stylua: ignore start
        map("x", "ghs", function() gitsigns.stage_hunk(selected_lines()) end, "Stage selected lines")
        map("x", "ghr", function() gitsigns.reset_hunk(selected_lines()) end, "Reset selected lines")
        map("n", "ghs", gitsigns.stage_hunk,                                  "Stage hunk")
        map("n", "ghr", gitsigns.reset_hunk,                                  "Reset hunk")
        map("n", "ghS", gitsigns.stage_buffer,                                "Stage buffer")
        map("n", "ghR", gitsigns.reset_buffer,                                "Reset buffer")
        map("n", "ghp", gitsigns.preview_hunk,                                "Preview hunk")
        map("n", "ghi", gitsigns.preview_hunk_inline,                         "Preview hunk inline")
        map("n", "ghb", function() gitsigns.blame_line({ full = true }) end,  "Blame line")
        map("n", "ghB", gitsigns.toggle_current_line_blame,                   "Toggle line blame")
        map("n", "ghw", gitsigns.toggle_word_diff,                            "Toggle word diff")
        map("n", "ghd", gitsigns.diffthis,                                    "Diff against index")
        map("n", "ghD", function() gitsigns.diffthis("~") end,                "Diff against last commit")
        map("n", "ghq", gitsigns.setqflist,                                   "Hunks in this file to quickfix")
        map("n", "ghQ", function() gitsigns.setqflist("all") end,             "Hunks in repo to quickfix")
        map({ "o", "x" }, "ih", gitsigns.select_hunk,                         "Inside hunk")
        -- stylua: ignore end
      end,
    },
  },
  { --- https://github.com/nvim-mini/mini.nvim
    "nvim-mini/mini.nvim",
    event = "VeryLazy",
    keys = {
      {
        "<leader>C",
        function()
          require("mini.hipatterns").toggle()
        end,
        desc = "Toggle hex colour highlighting",
      },
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
        draw = { animation = indentscope.gen_animation.none() },
        symbol = "░",
      })

      local hipatterns = require("mini.hipatterns")
      hipatterns.setup({
        highlighters = { hex_color = hipatterns.gen_highlighter.hex_color() },
      })

      -- Extra textobjects: a(rgument), f(unction call), q(uote), b(racket), t(ag), etc.
      -- The next/last variants are moved to aN/iN/aL/iL so the builtin an/in
      -- (incremental selection) and al/il (buffer and line) keep working (see :h MiniAi-default-an-in)
      require("mini.ai").setup({
        mappings = {
          around_next = "aN",
          inside_next = "iN",
          around_last = "aL",
          inside_last = "iL",
        },
        n_lines = 500,
      })

      -- Replaces tpope/vim-surround with the same keys: ys, ds, cs, yss and S in visual mode
      -- (see :h MiniSurround-vim-surround-config)
      require("mini.surround").setup({
        mappings = {
          add = "ys",
          delete = "ds",
          find = "",
          find_left = "",
          highlight = "",
          replace = "cs",
          suffix_last = "",
          suffix_next = "",
        },
        search_method = "cover_or_next",
      })
      vim.keymap.del("x", "ys")
      vim.keymap.set(
        "x",
        "S",
        [[:<C-u>lua MiniSurround.add('visual')<CR>]],
        { silent = true, desc = "Add surrounding" }
      )
      vim.keymap.set("n", "yss", "ys_", { remap = true, desc = "Surround line" })
    end,
  },
  { --- https://github.com/mechatroner/rainbow_csv
    "mechatroner/rainbow_csv",
    ft = { "csv", "tsv" },
  },
  { --- https://github.com/ggml-org/llama.vim
    -- NOTE: requires you to run something like the following, prior to usage:
    -- llama-server -hf ggml-org/Qwen2.5-Coder-3B-Q8_0-GGUF port 8012 -ub 1024 -b 1024 --ctx-size 0 --cache-reuse 256 -ngl 99
    "ggml-org/llama.vim",
    event = "InsertEnter",
    init = function()
      vim.g.llama_config = {
        show_info = 2,
        auto_fim = false, -- do not open FIM automatically
        keymap_fim_trigger = "<A-f>",
        keymap_fim_accept_full = "<A-y>",
        keymap_fim_accept_line = "<A-l>",
        keymap_fim_accept_word = "<A-w>",
        keymap_fim_next = "<A-]>",
        keymap_fim_prev = "<A-[>",
        keymap_inst_accept = "<leader>aa",
        keymap_inst_trigger = "<leader>ai",
        keymap_inst_rerun = "<leader>ar",
        keymap_inst_continue = "<leader>ac",
        keymap_inst_cancel = "<Esc>",
        keymap_debug_toggle = "<leader>ad",
      }
    end,
  },
}
