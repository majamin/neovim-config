-- NOTE: plugin specific maps contained in each plugin file lua/plugins/*

local opts = { silent = true }
local expr_opts = { silent = true, expr = true }
local abbrev = require("user/functions").abbrev

-- Use `<ESC>` to close windows
vim.api.nvim_create_autocmd("FileType", {
  pattern = {
    "fugitive",
    "help",
    "lspinfo",
    "lspsagafinder",
    "man",
    "null-ls-info",
    "qf",
    "sagacodeaction",
    "startuptime",
  },
  callback = function()
    vim.keymap.set({ "n" }, "<ESC>", ":close<CR>", { silent = true })
  end,
})

-- Sanity
-- stylua: ignore start
vim.keymap.set({ "n"      }, "x"        , '"_x')
vim.keymap.set({ "n", "v" }, "<space>"  , "<Nop>",           opts)
vim.keymap.set({ "n"      }, "<ESC>"    , ":noh<CR>",        opts)
vim.keymap.set({ "n"      }, "zm"       , ":ZenMode<CR>",    opts, { desc = "Toggle zen mode" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"0p',             opts, { desc = "Paste from yank register" })
vim.keymap.set({      "v" }, "<"        , "<gv",             opts, { desc = "Indent lines out" })
vim.keymap.set({      "v" }, ">"        , ">gv",             opts, { desc = "Indent lines in" })
vim.keymap.set({ "n"      }, "<BS>"     , "<C-^>",           opts, { desc = "Jump to alternate buffer" })
vim.keymap.set({ "n"      }, "<C-w>b"   , ":Bdelete<CR>",    opts, { desc = "Kill buffer" })
vim.keymap.set({ "n"      }, "<F3>", ":setlocal spell!<CR>", opts, { desc = "Toggle spelling" })
vim.keymap.set({ "n"      }, "k"        , "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set({ "n"      }, "j"        , "v:count == 0 ? 'gj' : 'j'", expr_opts)
vim.keymap.set({ "n"      }, "<F4>", ":setlocal spell! spelllang=en-basic<CR>", opts, { desc = "Toggle basic English spelling" })

-- Abbreviations
abbrev("ssss", "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒")

-- stylua: ignore end
