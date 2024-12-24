local M = {
  "saghen/blink.cmp",
  dependencies = { "L3MON4D3/LuaSnip", { "folke/lazydev.nvim", ft = "lua" } },
  version = "v0.*",
  opts_extend = { "sources.default" },
  event = { "BufReadPost", "BufNewFile" },
}

M.opts = {
  keymap = {
    preset = "super-tab",
    ["<C-n>"] = { "select_next", "show", "fallback" },
  },
  appearance = {
    use_nvim_cmp_as_default = false,
    nerd_font_variant = "mono",
  },
  snippets = {
    expand = function(snippet)
      require("luasnip").lsp_expand(snippet)
    end,
    active = function(filter)
      if filter and filter.direction then
        return require("luasnip").jumpable(filter.direction)
      end
      return require("luasnip").in_snippet()
    end,
    jump = function(direction)
      require("luasnip").jump(direction)
    end,
  },
  sources = {
    default = { "lazydev", "lsp", "path", "luasnip", "snippets", "buffer" },
    providers = {
      lazydev = {
        name = "LazyDev",
        module = "lazydev.integrations.blink",
        score_offset = 100,
      },
    },
  },
}

return M
