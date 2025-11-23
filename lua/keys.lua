local M = {}

M.non_plugin_maps = {
  -- stylua: ignore start
  { "<Esc>", "<cmd>nohlsearch<CR>" },
  { "<F2>", function () vim.cmd(":wa|mksession!") end, desc = "Save session and files", },
  { "<F3>", function () vim.cmd(":so Session.vim") end, desc = "Load session", },
  { "<F4>", ":setlocal spell!<CR>", desc = "Toggle spellcheck" },
  { "-", "<cmd>Oil<CR>", desc = "Browse files with Oil" },
  { "<C-w>b", "<cmd>bdelete<CR>", desc = "Close buffer" },
  { "<leader>q", function() require("snacks").picker.diagnostics() end, desc = "Show diagnostics", icon = "", },
  { "]d", vim.diagnostic.goto_next, desc = "Next diagnostic" },
  { "[d", vim.diagnostic.goto_prev, desc = "Previous diagnostic" },
  { "<leader>e", "<cmd>!xdg-open $(pwd) &>/dev/null &<CR><CR>", desc = "Open file explorer", icon = "󱢴" },
  { "<leader>i", icon = "", group = "Paste images" },
  { "<leader>ii", ':r!imaging.sh . <CR><CR>', desc = "Find and paste image paths", },
  { "<leader>is", ':r!imaging.sh "${SCREENSHOT_DIR:-$HOME/Pictures}" <CR><CR>', desc = "Screenshot images", },
  { "<leader>ip", ':r!imaging.sh "${HOME}/Pictures/SM-S921W/DCIM"   <CR><CR>', desc = "Phone photos", },
  -- stylua: ignore end
}

return M
