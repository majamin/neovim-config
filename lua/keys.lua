local M = {}

local loclist_is_open = require("funs").loclist_is_open

M.non_plugin_maps = {
  -- stylua: ignore start
  { "j", "gj" },
  { "k", "gk" },
  -- incremental selection uses the builtin an/in (treesitter, with LSP fallback)
  -- (]n and [n select the next and previous sibling node in visual mode)
  { "<CR>", "van", desc = "Start incremental selection", mode = "n", remap = true },
  { "<CR>", "an",  desc = "Expand selection",            mode = "x", remap = true },
  { "<BS>", "in",  desc = "Shrink selection",            mode = "x", remap = true },
  { "<Esc>", "<cmd>nohlsearch<CR>", desc = "Clear search highlight" },
  { "<F2>", function () vim.cmd(":wa|mksession!") end, desc = "Save session and files", },
  { "<F3>", function () vim.cmd(":so Session.vim") end, desc = "Load session", },
  { "<F4>", ":setlocal spell!<CR>", desc = "Toggle spellcheck" },
  { "<C-w>b", "<cmd>bdelete<CR>", desc = "Close buffer" },
  { "<leader>d", function()
    if loclist_is_open() then
      vim.cmd("lclose")
    else
      vim.diagnostic.setloclist({ open = true })
    end
  end, desc = "Toggle location list diagnostics", icon = "", },
  { "<leader>D", function()
    vim.diagnostic.enable(not vim.diagnostic.is_enabled())
  end, desc = "Toggle diagnostics visibility" },
  { "U", "<cmd>Undotree<CR>", desc = "Toggle undo tree", icon = "⎌" },
  { "<leader>e", function() vim.ui.open(vim.fn.getcwd()) end, desc = "Open file explorer", icon = "󱢴" },
  { "<leader>c", group = "Compile", icon = "" },
  { "<leader>cc", function() require("funs").compile() end, desc = "Compile document" },
  { "<leader>cw", function() require("funs").compile_watch() end, desc = "Toggle compile on change (entr)" },
  { "<leader>co", function()
    vim.system({ "compiler", "-o", vim.api.nvim_buf_get_name(0) })
  end, desc = "Open compiled document" },
  { "<leader>i", icon = "", group = "Paste images" },
  { "gl", group = "LSP", mode = { "n", "x" } },
  { "gh", group = "Git", mode = { "n", "x" } },
  -- fugitive, alongside the gitsigns hunk maps under gh (g? lists the keys in the status window)
  { "ghg", "<cmd>Git<CR>",               desc = "Status (fugitive, g? for keys)" },
  { "ghc", "<cmd>Git commit<CR>",        desc = "Commit" },
  { "ghl", "<cmd>Git log --oneline<CR>", desc = "Log" },
  { "gha", "<cmd>Git blame<CR>",         desc = "Blame file" },
  { "ghP", "<cmd>Git push<CR>",          desc = "Push" },
  { "<leader>ii", ':r!imaging.sh . <CR><CR>', desc = "Images in current project", },
  { "<leader>ip", ':r!imaging.sh ${SCREENSHOT_DIR} ${HOME}/Downloads ${HOME}/Pictures <CR><CR>', desc = "Screenshots", },
  -- stylua: ignore end
}

-- Do not remove - it ensures custom snippet jump binds hold
pcall(vim.keymap.del, { "i", "s" }, "<Tab>")
pcall(vim.keymap.del, { "i", "s" }, "<S-Tab>")

return M
