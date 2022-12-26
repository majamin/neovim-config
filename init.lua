require("user/options")

require("bootstrap")
require("lazy").setup("plugins", {
  checker = {
    enabled = true,
    notify = false,
  },
})

require("user/autocmd")
require("user/functions")
require("user/maps")
require("user/wsl_fix_cursor")
