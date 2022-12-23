--[[ IGNITION ]]
-- Tweak your settings here: `lua/user/init.lua`

--[[ MEAT ]]
require("user.maps")    -- `lua/user/maps.lua`
require("user.plugins") -- `lua/user/plugins.lua`
require("user.base")    -- `lua/user/base.lua`
require("user.autocmd") -- `lua/user/autocmd.lua`

--[[ SAD BUT TRUE ]]
-- This file fixes weird Windows Terminal cursor issues
-- Just add an empty file ~/.wsl_true to activate this.
require("user.wsl_fix_cursor")
