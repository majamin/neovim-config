local M = {
  "jpalardy/vim-slime",
}

function M.config()
  vim.g.slime_target = "tmux"
  vim.g.slime_default_config = { socket_name = "default", target_pane = "1" }
end

function M.init()
  vim.keymap.set({ "x" }, "<C-s><C-s>", "<Plug>SlimeRegionSend", { silent = true })
  vim.keymap.set({ "n" }, "<C-s><C-s>", "<Plug>SlimeParagraphSend", { silent = true })
  vim.keymap.set({ "n" }, "<C-s>v", "<Plug>SlimeConfig", { silent = true })
end

return M
