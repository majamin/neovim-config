local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    -- https://github.com/rafamadriz/friendly-snippets
    {
      "rafamadriz/friendly-snippets",
      config = function()
        require("luasnip.loaders.from_vscode").lazy_load()
      end,
    },
  },
  event = { "BufReadPost", "BufNewFile" },
  version = "v2.*",
  build = (function()
    -- Remove the below condition to re-enable on windows.
    if vim.fn.has("win32") == 1 or vim.fn.executable("make") == 0 then
      return
    end
    return "make install_jsregexp"
  end)(),
}

M.config = function()
  require("luasnip").setup({ enable_autosnippets = true })
  require("luasnip.loaders.from_lua").load({
    paths = os.getenv("XDG_CONFIG_HOME") .. "/nvim/lua/user/snip",
  })
end

return M
