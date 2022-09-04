local status, cmp = pcall(require, "cmp")
if not status then
  return
end
local status2, lspkind = pcall(require, "lspkind")
if not status2 then
  return
end

cmp.setup({
  mapping = cmp.mapping.preset.insert({
    ["<C-d>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-e>"] = cmp.mapping.close(),
    ["<C-x>"] = cmp.mapping.complete(),
    ["<C-y>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    }),
  }),
  sources = cmp.config.sources({
    -- { name, = "gh_issues"},
    { name = "nvim_lua" },
    { name = "nvim_lsp" },
    { name = "luasnip" },
    { name = "path" },
    { name = "buffer", keyword_length = 5 },
  }),
  formatting = {
    format = lspkind.cmp_format({ with_text = false, maxwidth = 50 }),
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
})
