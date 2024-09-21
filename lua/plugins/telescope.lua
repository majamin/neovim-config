local M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "debugloop/telescope-undo.nvim" },
    { "folke/which-key.nvim" },
  },
  VeryLazy = true,
}

M.config = function()
  require("telescope").setup({
    pickers = {
      colorscheme = {
        enable_preview = true,
      },
    },
  })

  require("telescope").load_extension("undo")
  local extensions = require("telescope").extensions
  local builtin = require("telescope.builtin")
  local wk = require("which-key")

  -- Lazy loads on these mappings
  wk.add({
    {
      "<leader>f",
      builtin.find_files,
      desc = "Telescope: find files",
    },
    {
      "<leader>g",
      builtin.live_grep,
      desc = "Telescope: grep in file",
    },
    {
      "<leader>h",
      builtin.help_tags,
      desc = "Telescope: help tags"
    },
    {
      "<leader>o",
      builtin.oldfiles,
      desc = "Telescope: recent files",
    },
    {
      "<leader><leader>",
      builtin.builtin,
      desc = "Telescope: menu"
    },
    {
      "U",
      extensions.undo.undo,
      desc = "Telescope: undo list"
    },
  })
end

return M
