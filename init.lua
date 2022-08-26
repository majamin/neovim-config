-- Don't forget to set your user defaults:
-- lua/user/user-conf.lua
require("user.user-conf")
require("user.plugins")
require("user.base")
require("user.maps")
require("user.autocmd")
require("user.highlights")
require("user.vimwiki")

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has("macunix")
local is_win = has("win32")

if is_mac then
  require("user.macos")
end
if is_win then
  require("user.windows")
end
