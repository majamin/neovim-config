local M = {
  "vimwiki/vimwiki",
  cmd = { "VimwikiIndex" },
}

local opts = { silent = true }

M.keys = {
  { "<S-F19>", "<Plug>VimwikiNextLink",   opts, desc = "(Workaround!) Vimwiki stole TAB" },
  { "<S-F18>", "<Plug>VimwikiPrevLink",   opts, desc = "(Workaround!) Vimiwiki stole S-TAB" },
  { ";w",      "<Plug>VimwikiIndex",      opts, desc = "Open default Vimwiki" },
  { ";wi",     "<Plug>VimwikiDiaryIndex", opts, desc = "Open default Vimwiki" },
  { ";ws",     "<Plug>VimwikiUISelect",   opts, desc = "Open Vimwiki UI Select" },
  { ";wt",     "<Plug>VimwikiTabIndex",   opts, desc = "Open Vimwiki Tab Index" },
}

return M
