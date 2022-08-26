local status, mason = pcall(require, "mason")
if not status then
  return
end
local status2, lspconfig = pcall(require, "mason-lspconfig")
if not status2 then
  return
end

mason.setup({})

local servers = require("user.user-conf").servers
lspconfig.setup({
  ensure_installed = servers,
})
