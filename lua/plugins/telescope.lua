local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    {
      "folke/trouble.nvim",
      dependencies = "nvim-tree/nvim-web-devicons",
    },
    { "nvim-telescope/telescope-symbols.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = { "Tel", "Telescope" },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")

  telescope.setup({
    defaults = {
      layout_strategy = "horizontal",
      layout_config = {
        prompt_position = "top",
      },
      sorting_strategy = "ascending",
      mappings = {
        i = {
          ["<C-h>"] = actions.file_split,
          ["<C-s>"] = actions.file_vsplit,
          ["<C-t>"] = trouble.smart_open_with_trouble,
        },
      },
    },
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
  })
  telescope.load_extension("fzf")
end

M.keys = {
  {
    ";f",
    function()
      require("user/funs").project_files()
    end,
    desc = "Find Tracked Project Files",
  },
  {
    ";o",
    function()
      require("telescope.builtin").oldfiles()
    end,
    desc = "Recent (Old) Files",
  },
  {
    ";g",
    function()
      require("telescope.builtin").live_grep()
    end,
    desc = "Grep Files",
  },
  {
    ";b",
    function()
      require("telescope.builtin").buffers()
    end,
    desc = "Find Buffers",
  },
  {
    ";h",
    function()
      require("telescope.builtin").help_tags()
    end,
    desc = "Find Help Tags",
  },
  {
    ";k",
    function()
      require("telescope.builtin").keymaps()
    end,
    desc = "Find Keymaps",
  },
  {
    ";e",
    function()
      require("telescope.builtin").diagnostics()
    end,
    desc = "View LSP diagnostics",
  },
  {
    ";;",
    "<cmd>Telescope<CR>",
    desc = "Open Telescope",
  },
}

return M
