local status, harpoon = pcall(require, "harpoon")
if not status then
  return
end

local settings = {
  -- sets the marks upon calling `toggle` on the ui, instead of require `:w`.
  save_on_toggle = false,

  -- saves the harpoon file upon every change. disabling is unrecommended.
  save_on_change = true,

  -- sets harpoon to run the command immediately as it's passed to the terminal when calling `sendCommand`.
  enter_on_sendcmd = false,

  -- closes any tmux windows harpoon that harpoon creates when you close Neovim.
  tmux_autoclose_windows = false,

  -- filetypes that you want to prevent from adding to the harpoon list menu.
  excluded_filetypes = { "harpoon" },

  -- set marks specific to each git branch inside git repository
  mark_branch = false,
}

harpoon.setup(settings)

-- Keymaps
vim.keymap.set("n", "<C-h>", function()
  require("harpoon.ui").toggle_quick_menu()
end, { desc = "Open harpoon" })
vim.keymap.set("n", "<leader>a", function()
  require("harpoon.mark").add_file()
  require("harpoon.ui").toggle_quick_menu()
  print("Added!")
end, { desc = "Add current file to harpoon" })

-- Quick select via 'leader'
local function harpoon_sel(n)
  vim.keymap.set("n", "<leader>" .. tostring(n), function()
    require("harpoon.ui").nav_file(n)
  end, { nowait = true }, { desc = "Open Harpoon file " .. tostring(n) })
end
for i = 1, 9 do
  harpoon_sel(i)
end

-- Go to next/prev Harpoon file
vim.keymap.set("n", "<TAB>", function()
  require("harpoon.ui").nav_next()
end, { nowait = true })
vim.keymap.set("n", "<S-TAB>", function()
  require("harpoon.ui").nav_prev()
end, { nowait = true })
