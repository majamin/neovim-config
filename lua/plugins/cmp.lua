local M = {
  "saghen/blink.cmp",
  dependencies = "L3MON4D3/LuaSnip",
  version = "v0.*",
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
  event = { "BufReadPost", "BufNewFile" },
}

M.opts = {
  -- 'default' for mappings similar to built-in completion
  -- 'super-tab' for mappings similar to vscode (tab to accept, arrow keys to navigate)
  -- 'enter' for mappings similar to 'super-tab' but with 'enter' to accept
  -- see the "default configuration" section below for full documentation on how to define
  -- your own keymap.
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
    default = { "lsp", "path", "luasnip", "snippets", "buffer" },
  },
}

return M
