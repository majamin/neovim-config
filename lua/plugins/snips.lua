local M = {
  "L3MON4D3/LuaSnip",
  dependencies = {
    "saadparwaiz1/cmp_luasnip",
    "rafamadriz/friendly-snippets",
  },
  lazy = true,
}

function M.config()
  local luasnip = require("luasnip")
  local vscode_loaders = require("luasnip.loaders.from_vscode")
  local lua_loaders = require("luasnip.loaders.from_lua")

  luasnip.filetype_extend("typescript", { "javascript" })

  local snip_env = {
    s = require("luasnip.nodes.snippet").S,
    sn = require("luasnip.nodes.snippet").SN,
    t = require("luasnip.nodes.textNode").T,
    f = require("luasnip.nodes.functionNode").F,
    i = require("luasnip.nodes.insertNode").I,
    c = require("luasnip.nodes.choiceNode").C,
    d = require("luasnip.nodes.dynamicNode").D,
    r = require("luasnip.nodes.restoreNode").R,
    l = require("luasnip.extras").lambda,
    rep = require("luasnip.extras").rep,
    p = require("luasnip.extras").partial,
    m = require("luasnip.extras").match,
    n = require("luasnip.extras").nonempty,
    dl = require("luasnip.extras").dynamic_lambda,
    fmt = require("luasnip.extras.fmt").fmt,
    fmta = require("luasnip.extras.fmt").fmta,
    conds = require("luasnip.extras.expand_conditions"),
    types = require("luasnip.util.types"),
    events = require("luasnip.util.events"),
    parse = require("luasnip.util.parser").parse_snippet,
    ai = require("luasnip.nodes.absolute_indexer"),
  }

  luasnip.config.set_config({ history = true, updateevents = "TextChanged,TextChangedI" })

  vscode_loaders.lazy_load()
  lua_loaders.load({ paths = os.getenv("HOME") .. "/.config/nvim/snippets/" })
end

function M.init()
  local luasnip = require("luasnip")
  vim.keymap.set({ "i", "s" }, "<c-j>", function()
    if luasnip.expand_or_jumpable() then
      luasnip.expand_or_jump()
    end
  end, { silent = true }, { desc = "Jump to next item in active snippet" })

  vim.keymap.set({ "i", "s" }, "<c-k>", function()
    if luasnip.jumpable(-1) then
      luasnip.jump(-1)
    end
  end, { silent = true }, { desc = "Jump to previous item in active snippet" })

  vim.keymap.set("i", "<c-h>", function()
    if luasnip.choice_active() then
      luasnip.change_choice(1)
    end
  end, { desc = "Snippets - select within a list of options" })
end

return M
