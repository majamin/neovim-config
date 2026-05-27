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
          "${3rd}/luv/library",
          "${3rd}/love2d/library",
        },
      },
      hint = {
        enable = true,
        paramName = "all", -- "all", "literals", "callable", "none"
        setType = true,    -- show inferred types
        await = true,
      },
    },
  },
}
