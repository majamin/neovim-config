local status, impatient = pcall(require, "impatient")
if status then
  impatient.enable_profile()
end

-- Don't forget to set your user defaults:
-- lua/user/user-conf.lua
require("user.user-conf")

require("user.plugins")
require("user.base")
require("user.maps")
require("user.autocmd")
require("user.vimwiki")

-- Fixes the cursor colors in Windows Terminal
-- https://github.com/microsoft/terminal/issues/9610
require("user.windows")
