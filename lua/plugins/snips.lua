local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  keys = { "<C-n>" }
}

function M.config()
  local luasnip = require("luasnip")
  local vscode_loaders = require("luasnip.loaders.from_vscode")
  local lua_loaders = require("luasnip.loaders.from_lua")

  luasnip.filetype_extend("typescript", { "javascript" })
  luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })
  vscode_loaders.lazy_load()
  lua_loaders.load({ paths = os.getenv("HOME") .. "/.config/nvim/snippets/" })
end

return M
