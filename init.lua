require("bootstrap")
require("user/options")

require("lazy").setup("plugins", require("user").lazy_opts)

require("user/autocmd")
require("user/functions")
require("user/maps")
require("user/wsl_fix_cursor")
