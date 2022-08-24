require("majamin.packer_init")
require("majamin.base")
require("majamin.vimwiki")
require("majamin.autocmd")
require("majamin.highlights")
require("majamin.maps")
require("majamin.plugins")

local has = function(x)
  return vim.fn.has(x) == 1
end
local is_mac = has("macunix")
local is_win = has("win32")

if is_mac then
  require("majamin.macos")
end
if is_win then
  require("majamin.windows")
end
