require("lazy_install")
require("user/opts")
require("user/keys")
require("user/auto")
require("lazy").setup("plugins", {
  change_detection = {
    enabled = true,
    notify = false,
  },
})
