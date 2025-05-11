return {
  cmd = { "lua-language-server" },
  filetypes = { "lua" },
  root_markers = { ".editorconfig", ".luarc.json", ".luarc.jsonc" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
      },
      workspace = {
        checkThirdParty = false,
        library = {
          vim.env.VIMRUNTIME,
          "${3rd}/love2d/library",
        },
      },
    },
  },
}
