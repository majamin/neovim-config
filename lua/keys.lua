local M = {}

local have_window_by_filetype = require("funs").have_window_by_filetype

M.non_plugin_maps = {
  -- stylua: ignore start
  { "<Esc>", "<cmd>nohlsearch<CR>" },
  { "j", "gj" },
  { "k", "gk" },
  { "<F2>", function () vim.cmd(":wa|mksession!") end, desc = "Save session and files", },
  { "<F3>", function () vim.cmd(":so Session.vim") end, desc = "Load session", },
  { "<F4>", ":setlocal spell!<CR>", desc = "Toggle spellcheck" },
  { "-", "<cmd>Oil<CR>", desc = "Browse files with Oil" },
  { "<C-w>b", "<cmd>bdelete<CR>", desc = "Close buffer" },
  { "gG", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, desc = "Toggle diagnostics" },
  { "<leader>q", function()
    if have_window_by_filetype("qf") then
      vim.cmd("lclose")
    else
      vim.diagnostic.setloclist({ open = true })
    end
  end
    , desc = "Toggle diagnostics", icon = "", },
  { "gl", vim.diagnostic.open_float, desc = "Line Diagnostics" },
  { "<C-j>", function() vim.diagnostic.jump({count = 1, float = true}) end, desc = "Next diagnostic" },
  { "<C-k>", function() vim.diagnostic.jump({count = -1, float = true}) end, desc = "Previous diagnostic" },
  { "<leader>e", "<cmd>!xdg-open $(pwd) &>/dev/null &<CR><CR>", desc = "Open file explorer", icon = "󱢴" },
  { "<leader>i", icon = "", group = "Paste images" },
  { "<leader>ii", ':r!imaging.sh . <CR><CR>', desc = "Images in current project", },
  { "<leader>ip", ':r!imaging.sh ${SCREENSHOT_DIR} ${HOME}/Downloads ${HOME}/Pictures <CR><CR>', desc = "Screenshots", },
  -- stylua: ignore end
}

local function feed(keys)
  return function()
    vim.api.nvim_feedkeys(
      vim.api.nvim_replace_termcodes(keys, true, false, true),
      "m", false
    )
  end
end
vim.keymap.set("n", "<Space>", feed("van"), { desc = "Start incremental selection" })
vim.keymap.set("x", "<Space>", feed("an"),  { desc = "Expand selection" })
vim.keymap.set("x", "<BS>",    feed("in"),  { desc = "Shrink selection" })

-- Do not remove - it ensures custom snippet jump binds hold
pcall(vim.keymap.del, { "i", "s" }, "<Tab>")
pcall(vim.keymap.del, { "i", "s" }, "<S-Tab>")

return M
