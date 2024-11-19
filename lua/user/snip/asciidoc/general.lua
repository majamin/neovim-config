local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("ifdefreveal", {
    t({
      "ifdef::backend-revealjs[]",
    }),
  }),
  s("stem", {
    t({ "stem:[" }),
    i(1, ""),
    t({ "]" }),
  }),
  s("latexmath", {
    t({ "[latexmath]", "" }),
    t({ "++++", "" }),
    i(1, ""),
    t({ "", "++++" }),
  }),
}

-- [latexmath%step#staircase-formula]
-- ++++
--   \left(\frac{m+n}{n}\right) = \frac{(m+n)!}{m!n!}
-- ++++
