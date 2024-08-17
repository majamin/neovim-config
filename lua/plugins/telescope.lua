local M = {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
  },
  cmd = { "Telescope" },
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

  local wk = require("which-key")

  -- Lazy loads on these mappings
  wk.add({
    {
      "<leader>f",
      ":Telescope find_files<CR>",
      desc = "Telescope: find files",
    },
    {
      "<leader>g",
      ":Telescope live_grep<CR>",
      desc = "Telescope: grep in file",
    },
    { "<leader>b", ":Telescope buffers<CR>", desc = "Telescope: find buffers" },
    { "<leader>h", ":Telescope help_tags<CR>", desc = "Telescope: help tags" },
    {
      "<leader>o",
      ":Telescope oldfiles<CR>",
      desc = "Telescope: recent files",
    },
    { "<leader><leader>", ":Telescope<CR>", desc = "Telescope: menu" },
  })
end

return M
