local M = {}

local have_window_by_filetype = require("funs").have_window_by_filetype
local feed = require("funs").feed

M.non_plugin_maps = {
  -- stylua: ignore start
  { "j", "gj" },
  { "k", "gk" },
  { "<Space>", feed("van"), desc = "Start incremental selection", mode = "n"},
  { "<Space>", feed("an"),  desc = "Expand selection",            mode = "x"},
  { "<BS>",    feed("in"),  desc = "Shrink selection",            mode = "x"},
  { "<C-l>",   feed("v]n"), desc = "Select next node",            mode = "n"},
  { "<C-l>",   feed("]n"),  desc = "Select next node",            mode = "x"},
  { "<C-h>",   feed("v[n"), desc = "Select next node",            mode = "n"},
  { "<C-h>",   feed("[n"),  desc = "Select previous node",        mode = "x"},
  { "<Esc>", "<cmd>nohlsearch<CR>" },
  { "<F2>", function () vim.cmd(":wa|mksession!") end, desc = "Save session and files", },
  { "<F3>", function () vim.cmd(":so Session.vim") end, desc = "Load session", },
  { "<F4>", ":setlocal spell!<CR>", desc = "Toggle spellcheck" },
  { "-", "<cmd>Oil<CR>", desc = "Browse files with Oil" },
  { "<C-w>b", "<cmd>bdelete<CR>", desc = "Close buffer" },
  { "<leader>d", function()
    if have_window_by_filetype("qf") then
      vim.cmd("lclose")
    else
      vim.diagnostic.setloclist({ open = true })
    end
  end, desc = "Toggle quickfix diagnostics", icon = "", },
  { "<leader>D", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, desc = "Toggle diagnostics visibility" },
  { "]d", function() vim.diagnostic.jump({count = 1, float = true}) end, desc = "Next diagnostic" },
  { "[d", function() vim.diagnostic.jump({count = -1, float = true}) end, desc = "Previous diagnostic" },
  { "<leader>e", "<cmd>!xdg-open $(pwd) &>/dev/null &<CR><CR>", desc = "Open file explorer", icon = "󱢴" },
  { "<leader>i", icon = "", group = "Paste images" },
  { "<leader>ii", ':r!imaging.sh . <CR><CR>', desc = "Images in current project", },
  { "<leader>ip", ':r!imaging.sh ${SCREENSHOT_DIR} ${HOME}/Downloads ${HOME}/Pictures <CR><CR>', desc = "Screenshots", },
  -- stylua: ignore end
}

-- Do not remove - it ensures custom snippet jump binds hold
pcall(vim.keymap.del, { "i", "s" }, "<Tab>")
pcall(vim.keymap.del, { "i", "s" }, "<S-Tab>")

return M
