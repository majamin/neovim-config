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

local opts = { noremap = true, silent = false }

local numSlots = 9 -- how many targets would we like?

vim.keymap.set("n", "ta", function()
  return require("harpoon.mark").add_file()
end, opts)

vim.keymap.set("n", "tt", function()
  return require("harpoon.ui").toggle_quick_menu()
end, opts)

for i = 1, numSlots do
  vim.keymap.set("n", "t" .. i, function()
    return require("harpoon.ui").nav_file(i)
  end, opts)
end

vim.cmd([[
augroup harpoonkeys
  autocmd! harpoonkeys
  autocmd Filetype harpoon nnoremap <buffer> <silent> <nowait> 1 :lua require('harpoon.ui').nav_file(1)<CR>
  autocmd Filetype harpoon nnoremap <buffer> <silent> <nowait> 2 :lua require('harpoon.ui').nav_file(2)<CR>
  autocmd Filetype harpoon nnoremap <buffer> <silent> <nowait> 3 :lua require('harpoon.ui').nav_file(3)<CR>
  autocmd Filetype harpoon nnoremap <buffer> <silent> <nowait> 4 :lua require('harpoon.ui').nav_file(4)<CR>
  autocmd Filetype harpoon nnoremap <buffer> <silent> <nowait> 5 :lua require('harpoon.ui').nav_file(5)<CR>
  autocmd Filetype harpoon nnoremap <buffer> <silent> <nowait> 6 :lua require('harpoon.ui').nav_file(6)<CR>
  autocmd Filetype harpoon nnoremap <buffer> <silent> <nowait> 7 :lua require('harpoon.ui').nav_file(7)<CR>
  autocmd Filetype harpoon nnoremap <buffer> <silent> <nowait> 8 :lua require('harpoon.ui').nav_file(8)<CR>
augroup end
]])
