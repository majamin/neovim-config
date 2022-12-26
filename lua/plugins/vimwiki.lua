local M = {
  "vimwiki/vimwiki",
}

function M.init()
  local opts = { silent = true }
  vim.g.vimwiki_global_ext  = 0 -- Don't vimwiki every goddamn md file, please
  vim.g.vimwiki_url_maxsave = 0 -- Don't shorten URL so you can plumb links
  vim.g.vimwiki_list = { { path = os.getenv("ONEDRIVE") .. "/Projects/notes" } }
  vim.keymap.set("n", "<S-F19>", "<Plug>VimwikiNextLink", opts, { desc = "Unnecessary Vimwiki binding" })
  vim.keymap.set("n", "<S-F18>", "<Plug>VimwikiPrevLink", opts, { desc = "Unnecessary Vimwiki binding" })
  vim.keymap.set("n", ",w", "<Plug>VimwikiIndex", opts, { desc = "Open default Vimwiki" })
  vim.keymap.set("n", ",wi", "<Plug>VimwikiDiaryIndex", opts, { desc = "Open default Vimwiki" })
  vim.keymap.set("n", ",ws", "<Plug>VimwikiUISelect", opts, { desc = "Open Vimwiki UI Select" })
  vim.keymap.set("n", ",wt", "<Plug>VimwikiTabIndex", opts, { desc = "Open Vimwiki Tab Index" })
end

return M
