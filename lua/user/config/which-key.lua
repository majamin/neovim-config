local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local options = { silent = true }

wk.setup({
  hidden = {
    "<silent>",
    "<Plug>",
    "<cmd>",
    "<Cmd>",
    "<cr>",
    "<CR>",
    "call",
    "lua",
    "require",
    "^:",
    "^ ",
  },
})

wk.register({
  ["<Tab>"] = { "<cmd>e#<cr>", "Prev buffer" },
})

-- Harpoon <C-h>
wk.register({
  ["<C-h>"] = {
    function()
      return require("harpoon.ui").toggle_quick_menu()
    end,
    "Open harpoon menu",
  },
  a = {
    function()
      return require("harpoon.mark").add_file()
    end,
    "Add current file to harpoon list",
  },
}, { prefix = "<C-h>", mode = "n", options })

-- LSP <C-l>
vim.keymap.del("n", "<C-l>")
wk.register({
  name = "LSP",
  a = { "<cmd>Lspsaga code_action<CR>", "Code action" },
  d = { "<cmd>Lspsaga peek_definition<CR>", "Peek definition" },
  h = { "<cmd>Lspsaga lsp_finder<CR>", "Find definition" },
  n = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Next diagnostic" },
  o = { "<cmd>LSoutlineToggle<CR>", "Outline" },
  r = { "<cmd>Lspsaga rename<CR>", "Rename object" },
  s = { "<Cmd>Lspsaga signature_help<CR>", "Signature help" },
}, { prefix = "<C-l>", mode = "n" })
wk.register({
  name = "LSP",
  K = { "<cmd>Lspsaga hover_doc<CR>", "LSP hover doc" },
})

-- Vimwiki <leader>
vim.keymap.set("n", "<S-F19>", "<Plug>VimwikiNextLink")
vim.keymap.set("n", "<S-F18>", "<Plug>VimwikiPrevLink")
wk.register({
  w = {
    name = "Vimwiki",
    w = { "<Plug>VimwikiIndex", "Open default Vimwiki" },
  },
}, { prefix = "<leader>", mode = "n", options })
