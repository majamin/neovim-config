local g = vim.g

g.slime_target = "tmux"

vim.cmd([[
let g:slime_default_config = {"socket_name": get(split($TMUX, ","), 0), "target_pane": ":.1"}
]])

vim.keymap.set("x", "<space>s", "<Plug>SlimeRegionSend")
vim.keymap.set("n", "<space>s", "<Plug>SlimeParagraphSend")
