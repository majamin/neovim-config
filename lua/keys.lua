local M = {}

local have_window_by_filetype = require("funs").have_window_by_filetype

M.non_plugin_maps = {
  -- stylua: ignore start
  { "<Esc>", "<cmd>nohlsearch<CR>" },
  { "<F2>", function () vim.cmd(":wa|mksession!") end, desc = "Save session and files", },
  { "<F3>", function () vim.cmd(":so Session.vim") end, desc = "Load session", },
  { "<F4>", ":setlocal spell!<CR>", desc = "Toggle spellcheck" },
  { "-", "<cmd>Oil<CR>", desc = "Browse files with Oil" },
  { "<C-w>b", "<cmd>bdelete<CR>", desc = "Close buffer" },
  { "<leader>q", function()
      if have_window_by_filetype("qf") then
        vim.cmd("lclose")
      else
        vim.diagnostic.setloclist({ open = true })
      end
    end
    , desc = "Toggle diagnostics", icon = "", },
  -- { "<leader><leader>", vim.lsp.buf.format, desc = "Format the buffer", icon = "󰉩" },
  { "<leader>e", "<cmd>!dolphin . &>/dev/null &<CR><CR>", desc = "Open file explorer", icon = "󱢴" },
  { "<leader>i", icon = "", group = "Paste images" },
  { "<leader>ii", ':r!imaging.sh . <CR><CR>', desc = "Find and paste image paths", },
  { "<leader>is", ':r!imaging.sh "${SCREENSHOT_DIR:-$HOME/Pictures}" <CR><CR>', desc = "Screenshot images", },
  { "<leader>ip", ':r!imaging.sh "${HOME}/Pictures/SM-S901W/DCIM"   <CR><CR>', desc = "Phone photos", },
  -- stylua: ignore end
}

return M
