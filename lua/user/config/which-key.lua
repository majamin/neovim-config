local status_ok, wk = pcall(require, "which-key")
if not status_ok then
  return
end

local options = { silent = true }

wk.setup({
  layout = {
    height = { min = 4, max = 25 }, -- min and max height of the columns
    width = { min = 20, max = 50 }, -- min and max width of the columns
    spacing = 2, -- spacing between columns
    align = "center", -- align columns left, center or right
  },
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

-- WHY HERE?!?!?
vim.keymap.del("n", "<C-l>")

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

-- Vimwiki <leader>
vim.keymap.set("n", "<S-F19>", "<Plug>VimwikiNextLink")
vim.keymap.set("n", "<S-F18>", "<Plug>VimwikiPrevLink")
wk.register({
  w = {
    name = "Vimwiki",
    w = { "<Plug>VimwikiIndex", "Open default Vimwiki" },
  },
}, { prefix = "<leader>", mode = "n", options })
