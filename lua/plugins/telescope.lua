local M = {
  "nvim-telescope/telescope.nvim",
  cmd = { "Telescope", "Tel" },
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "folke/trouble.nvim" },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-symbols.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  lazy = true,
}

function M.config()
  local trouble = require("trouble.providers.telescope")
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local borderless = true
  local fb_actions = require("telescope").extensions.file_browser.actions

  telescope.setup({
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<c-t>"] = trouble.open_with_trouble,
          ["<C-Down>"] = actions.cycle_history_next,
          ["<C-Up>"] = actions.cycle_history_prev,
        },
      },
      -- mappings = { i = { ["<esc>"] = actions.close } },
      -- vimgrep_arguments = {
      --   'rg',
      --   '--color=never',
      --   '--no-heading',
      --   '--with-filename',
      --   '--line-number',
      --   '--column',
      --   '--smart-case'
      -- },
      -- prompt_position = "bottom",
      -- prompt_prefix = " ",
      -- selection_caret = " ",
      -- entry_prefix = "  ",
      -- initial_mode = "insert",
      -- selection_strategy = "reset",
      -- sorting_strategy = "descending",
      -- layout_strategy = "horizontal",
      -- layout_defaults = {
      --   horizontal = {
      --     mirror = false,
      --   },
      --   vertical = {
      --     mirror = false,
      --   },
      -- },
      -- file_sorter = require"telescope.sorters".get_fzy_file
      -- file_ignore_patterns = {},
      -- generic_sorter =  require'telescope.sorters'.get_generic_fuzzy_sorter,
      -- shorten_path = true,
      winblend = borderless and 0 or 10,
      -- width = 0.7,
      -- preview_cutoff = 120,
      -- results_height = 1,
      -- results_width = 0.8,
      -- border = false,
      -- color_devicons = true,
      -- use_less = true,
      -- set_env = { ['COLORTERM'] = 'truecolor' }, -- default = nil,
      -- file_previewer = require'telescope.previewers'.vim_buffer_cat.new,
      -- grep_previewer = require'telescope.previewers'.vim_buffer_vimgrep.new,
      -- qflist_previewer = require'telescope.previewers'.vim_buffer_qflist.new,

      -- -- Developer configurations: Not meant for general override
      -- buffer_previewer_maker = require'telescope.previewers'.buffer_previewer_maker
    },
    extensions = {
      file_browser = {
        theme = "dropdown",
        -- disables netrw and use telescope-file-browser in its place
        hijack_netrw = true,
        mappings = {
          -- your custom insert mode mappings
          ["i"] = {
            ["<C-w>"] = function()
              vim.cmd("normal vbd")
            end,
            ["<C-e>"] = fb_actions.create_from_prompt,
          },
          ["n"] = {
            -- your custom normal mode mappings
            ["x"] = fb_actions.remove,
            ["h"] = fb_actions.goto_parent_dir,
            ["l"] = function()
              vim.cmd('execute "normal \\<cr>"')
            end,
          },
        },
      },
    },
  })

  telescope.load_extension("fzf")
  telescope.load_extension("file_browser")
end

M.keys = {
  { "<leader><leader>", function() require("telescope.builtin") end, { desc = "Continue Finding ... " } },
  { "<leader>f", require("user/functions").project_files, { desc = "Find Files" } },
  { "<leader>w", require("user/functions").compact_browser, { desc = "Browse Files" }},
  { "<leader>o", function() require("telescope.builtin").oldfiles({ only_cwd = true }) end, { desc = "Old Files" }},
  { "<leader>g", function() require("telescope.builtin").live_grep() end, { desc = "Grep Files" }},
  { "<leader>b", function() require("telescope.builtin").buffers() end, { desc = "Find Buffers" }},
  { "<leader>h", function() require("telescope.builtin").help_tags() end, { desc = "Find Help Tags" }},
  { "<leader>k", function() require("telescope.builtin").keymaps() end, { desc = "Find Keymaps" }},
  { "<leader>e", function() require("telescope.builtin").diagnostics() end, { desc = "View LSP diagnostics" }},
}

return M
