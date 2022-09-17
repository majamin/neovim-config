local status_ok, leap = pcall(require, "leap")
if not status_ok then
  return
end
vim.keymap.set("n", "<S-l>", "<Plug>(leap-forward)", { desc = "Jump forward to bigram"})
vim.keymap.set("n", "<S-h>", "<Plug>(leap-backward)", { desc = "Jump back to bigram"})
vim.keymap.set("v", "<S-l>", "<Plug>(leap-forward)", { desc = "Jump forward to bigram"})
vim.keymap.set("v", "<S-h>", "<Plug>(leap-backward)", { desc = "Jump back to bigram"})
leap.set_default_keymaps()
