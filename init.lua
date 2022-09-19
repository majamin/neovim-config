local status, impatient = pcall(require, "impatient")
if status then
  impatient.enable_profile()
end

-- Don't forget to set your user defaults:
-- lua/user/user-conf.lua
require("user.plugins")
require("user.base")
require("user.maps")
require("user.autocmd")

-- Windows, WSL, ssh from Terminal?
-- Fixes: cursor colors
-- https://github.com/microsoft/terminal/issues/9610
require("user.windows") -- lua/user/windows.lua
