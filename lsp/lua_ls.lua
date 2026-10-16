-- lazydev adds the Neovim runtime and plugin types in Neovim config files.
-- Other projects (e.g. love2d) can add libraries in their own .luarc.json
return {
  settings = {
    Lua = {
      runtime = { version = "LuaJIT" },
      workspace = { checkThirdParty = false },
    },
  },
}
