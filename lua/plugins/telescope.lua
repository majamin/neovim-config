local M = {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "folke/trouble.nvim", dependencies = "nvim-tree/nvim-web-devicons" },
    { "nvim-telescope/telescope-symbols.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = { "Tel", "Telescope" },
  lazy = false,
}

function M.config()
  local wk = require("which-key")
  local telescope = require("telescope")
  local builtin = require("telescope.builtin")
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
          ["<C-v>"] = actions.file_vsplit,
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

  wk.register({
    f = { require("user/funs").project_files, "Find Tracked Project Files" },
    g = { builtin.live_grep, "Grep Files" },
    b = { builtin.buffers, "Find Buffers" },
    h = { builtin.help_tags, "Find Help Tags" },
    k = { builtin.keymaps, "Find Keymaps" },
    e = { builtin.diagnostics, "View LSP diagnostics" },
    [";"] = {
      function()
        builtin.oldfiles({ only_cwd = true })
      end,
      "Old Files",
    },
  }, { prefix = ";" })
end

return M
