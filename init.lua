--[[ IMPATIENT ]]
local status, impatient = pcall(require, "impatient")
if status then
  impatient.enable_profile()
end

--[[ IGNITION ]]
-- Go here: `lua/user/user-conf.lua`

--[[ MEAT ]]
require("user.plugins") -- `lua/user/plugins.lua`
require("user.base")    -- `lua/user/base.lua`
require("user.maps")    -- `lua/user/maps.lua`
require("user.autocmd") -- `lua/user/autocmd.lua`

--[[ SAD BUT TRUE ]]
if os.getenv("WT") then
  require("user.windows")
end
