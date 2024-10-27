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
    { "<leader>i", group = "[I]mage Handler" },
    { "<leader>l", group = "[L]SP" },
  })

  wk.add({
    { "x", '"_x', desc = "Delete character to blackhole register" },
    {
      "<F2>",
      function()
        vim.cmd(":wa|mksession!")
        vim.print("Session and files saved")
      end,
      desc = "Save session and files",
    },
    {
      "<F3>",
      function()
        vim.cmd(":so Session.vim")
      end,
      desc = "Load session",
    },
    { "<F4>", ":setlocal spell!<CR>", desc = "Toggle spellcheck" },
    {
      mode = { "v" },
      { "<", "<gv", desc = "Outdent visually selected region" },
      { ">", ">gv", desc = "Indent visually selected region" },
    },
    { "<TAB>", ":bn<CR>", desc = "Go to next buffer" },
    { "<S-TAB>", ":bp<CR>", desc = "Go to previous buffer" },
    { "<ESC>", ":noh<CR>", desc = "Turn off search highlight" },
    { "<BS>", "<C-^>", desc = "Return to previous buffer" },
    { "<C-w>b", ":bd<CR>", desc = "Delete current buffer" },
    { "<leader>p", '"0p', desc = "Paste from yank register" },
    { "<leader>c", ":ColorizerToggle<CR>", desc = "Toggle colorizer" },
    {
      "<leader>ii",
      ":r !fd -t f . -0 -e png -e jpg -e jpeg -e bmp -e svg | xargs -0 nsxiv -qto <CR><CR>",
      desc = "Find and paste image paths",
    },
    {
      "<leader>is",
      ":r!imaging.sh $HOME/Images/Screenshots <CR><CR> ",
      desc = "Copy screenshots to current project",
    },
    {
      "<leader>ip",
      ':r!imaging.sh "$ONEDRIVE/Common/phone-pictures/" <CR><CR> ',
      desc = "Copy phone photos to current project",
    },
  })
end

return M
