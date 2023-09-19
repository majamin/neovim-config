local M = {
  "hrsh7th/nvim-cmp",
  dependencies = {
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "hrsh7th/cmp-nvim-lsp",
    "rafamadriz/friendly-snippets",
    "onsails/lspkind-nvim",
  },
  enabled = true,
  event = "VeryLazy",
}

function M.config()
  local luasnip = require("luasnip")
  local vscode_loaders = require("luasnip.loaders.from_vscode")

  luasnip.filetype_extend("typescript", { "javascript" })
  luasnip.config.set_config({
    history = true,
    updateevents = "TextChanged,TextChangedI",
  })
  vscode_loaders.lazy_load()

  local cmp_autopairs = require("nvim-autopairs.completion.cmp")

  local has_words_before = function()
    unpack = unpack or table.unpack
    local line, col = unpack(vim.api.nvim_win_get_cursor(0))
    return col ~= 0
        and vim.api
        .nvim_buf_get_lines(0, line - 1, line, true)[1]
        :sub(col, col)
        :match("%s")
        == nil
  end

  local lspkind = require("lspkind")
  local cmp = require("cmp")

  cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
  cmp.setup({
    completion = {
      autocomplete = {
        require("user").autocmp
        and require("cmp.types").cmp.TriggerEvent.TextChanged,
      },
      -- completeopt = 'menu,menuone,noselect',
      -- keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
      -- keyword_length = 1,
    },
    mapping = {
      ["<C-n>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_next_item()
          -- You could replace the expand_or_jumpable() calls with expand_or_locally_jumpable()
          -- they way you will only jump inside the snippet region
        elseif luasnip.expand_or_jumpable() then
          luasnip.expand_or_jump()
        elseif has_words_before() then
          cmp.complete()
        else
          cmp.complete()
        end
      end, { "i", "s" }),
      ["<C-p>"] = cmp.mapping(function(fallback)
        if cmp.visible() then
          cmp.select_prev_item()
        elseif luasnip.jumpable(-1) then
          luasnip.jump(-1)
        else
          fallback()
        end
      end, { "i", "s" }),
      ["<C-u>"] = cmp.mapping.scroll_docs(-2),
      ["<C-d>"] = cmp.mapping.scroll_docs(2),
      ["<CR>"] = cmp.mapping({
        i = function(fallback)
          if cmp.visible() and cmp.get_active_entry() then
            cmp.confirm({
              behavior = cmp.ConfirmBehavior.Replace,
              select = false,
            })
          else
            fallback()
          end
        end,
        s = cmp.mapping.confirm({ select = true }),
        c = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
      }),
    },
    sources = {
      { name = "nvim_lua" },
      { name = "nvim_lsp" },
      { name = "path" },
      { name = "luasnip" },
      { name = "buffer",  keyword_length = 3 },
    },
    sorting = {
      comparators = {
        cmp.config.compare.offset,
        cmp.config.compare.exact,
        cmp.config.compare.score,
        function(entry1, entry2)
          local _, entry1_under = entry1.completion_item.label:find("^_+")
          local _, entry2_under = entry2.completion_item.label:find("^_+")
          entry1_under = entry1_under or 0
          entry2_under = entry2_under or 0
          if entry1_under > entry2_under then
            return false
          elseif entry1_under < entry2_under then
            return true
          end
        end,
        cmp.config.compare.kind,
        cmp.config.compare.sort_text,
        cmp.config.compare.length,
        cmp.config.compare.order,
      },
    },
    snippet = {
      expand = function(args)
        require("luasnip").lsp_expand(args.body)
      end,
    },
    formatting = {
      format = lspkind.cmp_format({
        mode = "symbol_text",
        -- with_text = false,
        menu = {
          buffer = "[txt]",
          nvim_lsp = "[lsp]",
          nvim_lua = "[lua]",
          path = "[path]",
          luasnip = "[snip]",
        },
      }),
    },
    experimental = {
      native_menu = false,
      ghost_text = false,
    },
  })

  local nice_cmp_colors = {
    -- gray
    {
      "CmpItemAbbrDeprecated",
      { bg = "NONE", strikethrough = true, fg = "#808080" },
    },
    -- blue
    { "CmpItemAbbrMatch",      { bg = "NONE", fg = "#569CD6" } },
    { "CmpItemAbbrMatchFuzzy", { link = "CmpIntemAbbrMatch" } },
    -- light blue
    { "CmpItemKindVariable",   { bg = "NONE", fg = "#9CDCFE" } },
    { "CmpItemKindInterface",  { link = "CmpItemKindVariable" } },
    { "CmpItemKindText",       { link = "CmpItemKindVariable" } },
    -- pink
    { "CmpItemKindFunction",   { bg = "NONE", fg = "#C586C0" } },
    { "CmpItemKindMethod",     { link = "CmpItemKindFunction" } },
    -- front
    { "CmpItemKindKeyword",    { bg = "NONE", fg = "#D4D4D4" } },
    { "CmpItemKindProperty",   { link = "CmpItemKindKeyword" } },
    { "CmpItemKindUnit",       { link = "CmpItemKindKeyword" } },
  }

  for _, v in ipairs(nice_cmp_colors) do
    local name, color = unpack(v)
    vim.api.nvim_set_hl(0, name, color)
  end
end

return M
