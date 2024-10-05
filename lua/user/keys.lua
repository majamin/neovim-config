local M = {
  "folke/which-key.nvim",
}

M.config = function()
  local wk = require("which-key")
  wk.setup({
    preset = "helix",
    delay = 1400,
  })

  require("which-key").add({
    { "<leader>c", group = "[C]ode" },
    { "<leader>d", group = "[D]ocument" },
    { "<leader>r", group = "[R]ename" },
    { "<leader>w", group = "[W]orkspace" },
    { "<leader>i", group = "Paste [I]mages" },
  })

  wk.add({
    { "x", '"_x', desc = "Delete character to blackhole register" },
    { "<F3>", ":setlocal spell!<CR>", desc = "Toggle spellcheck" },
    { "<TAB>", ":bn<CR>", desc = "Go to next buffer" },
    { "<S-TAB>", ":bp<CR>", desc = "Go to previous buffer" },
    { "<ESC>", ":noh<CR>", desc = "Turn off search highlight" },
    { "<BS>", "<C-^>", desc = "Return to previous buffer" },
    { "<C-w>b", ":bd<CR>", desc = "Delete current buffer" },
    { "<leader>p", '"0p', desc = "Paste from yank register" },
    {
      "<leader>ip",
      ":r !fd -t f . -0 -e png -e jpg -e jpeg -e bmp -e svg | xargs -0 nsxiv -qto <CR><CR>",
      desc = "Find and paste image paths",
    },
    {
      "<leader>is",
      ":r!imaging.sh $HOME/Pictures/Screenshots <CR><CR> ",
      desc = "Copy screenshots to current project",
    },
    {
      "<leader>ic",
      ':r!imaging.sh "$HOME/Pictures/sm-s901w_kbmv-photos/" <CR><CR> ',
      desc = "Copy phone photos to current project",
    },
    -- { '<leader>y', mode = { 'n', 'v' }, 'y<cr>:call system("tmux load-buffer -", @0)<cr>gv', desc = 'Yank to tmux clipboard' },
    -- { '<leader>p', mode = { 'n', 'v' }, ':let @0 = system("tmux save-buffer -")<cr>"0p<cr>g;', desc = 'Paste from tmux clipboard' },
    {
      "<F2>",
      function()
        vim.cmd(":wa|mksession!")
        vim.print("Session and files saved")
      end,
      desc = "Save session and files",
    },
  })
end

return M
