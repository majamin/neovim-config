-- NOTE: plugin specific maps contained in each plugin file lua/plugins/*

local opts = { silent = true }
local expr_opts = { silent = true, expr = true }
local abbrev = require("user/funs").abbrev

-- Use `<ESC>` to close windows
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "fugitive",
    "help",
    "lspinfo",
    "lspsagafinder",
    "man",
    "qf",
    "sagacodeaction",
    "startuptime",
    "lazy",
    "checkhealth",
  },
  callback = function()
    vim.keymap.set(
      { "n" },
      "<ESC>",
      "<cmd>close<CR>",
      { silent = true, buffer = true }
    )
  end,
})

-- Sanity
vim.keymap.set({ "n" }, "x", '"_x')
vim.keymap.set({ "n" }, "<ESC>", ":noh<CR>", opts)
vim.keymap.set(
  { "n", "v" },
  "<leader>p",
  '"0p',
  opts,
  { desc = "Paste from yank register" }
)
vim.keymap.set({ "v" }, "<", "<gv", opts, { desc = "Indent lines out" })
vim.keymap.set({ "v" }, ">", ">gv", opts, { desc = "Indent lines in" })
vim.keymap.set(
  { "n" },
  "<BS>",
  "<C-^>",
  opts,
  { desc = "Jump to alternate buffer" }
)
vim.keymap.set({ "n" }, "<TAB>", ":tabN<CR>", opts, { desc = "Go to next tab" })
vim.keymap.set(
  { "n" },
  "<S-TAB>",
  ":tabp<CR>",
  opts,
  { desc = "Go to next tab" }
)
vim.keymap.set(
  { "n" },
  "<C-w>b",
  ":Bdelete<CR>",
  opts,
  { desc = "Kill buffer" }
)
vim.keymap.set(
  { "n" },
  "<F3>",
  ":setlocal spell!<CR>",
  opts,
  { desc = "Toggle spelling" }
)
vim.keymap.set({ "n" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set({ "n" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
vim.keymap.set(
  { "n" },
  "<leader>i",
  ":r !find . -maxdepth 3 -print | file -if - | grep \"image/\" | cut -d':' -f1 | xargs sxiv -qto <CR><CR>",
  opts,
  { desc = "Find images in current working directory using sxiv" }
)

-- Yank and paste to tmux clipboard
vim.keymap.set(
  "v",
  "<leader><leader>y",
  'y<cr>:call system("tmux load-buffer -", @0)<cr>gv',
  opts,
  { desc = "Yank to the tmux clipboard" }
)
vim.keymap.set(
  "n",
  "<leader><leader>p",
  ':let @0 = system("tmux save-buffer -")<cr>"0p<cr>g;',
  opts,
  { desc = "Paste from the tmux clipboard" }
)

-- Abbreviations
abbrev(
  "ssss",
  "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒"
)
