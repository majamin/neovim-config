require("bootstrap")
vim.g.mapleader = require("user").mapleader
require("lazy").setup("plugins", {
  checker = {
    enabled = true,
    notify = false,
  },
})

require("user/options")
require("user/autocmd")
require("user/functions")
require("user/maps")
require("user/wsl_fix_cursor")
