if not require("user.user-conf").whichkey then return end

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
  disable = {
    buftypes = {},
    filetypes = { true },
  },
})
