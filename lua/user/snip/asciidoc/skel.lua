local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

return {
  s("skel", {
    t({
      "= ",
    }),
    i(1, "Document Title"),
    t({ "" }),
    t({
      "Author: ",
    }),
    i(2, "Author Name"),
    t({ "" }),
    t({
      "Date: ",
    }),
    t({ "{date}", "", "" }),
    t({
      "== Introduction",
      "",
      "Write your introduction here.",
      "",
      "== Table Example",
      "",
      "Here's an example table:",
      "",
      "|=== ",
      "| Column 1 | Column 2 | Column 3",
      "| Data 1   | Data 2   | Data 3",
      "| Data 4   | Data 5   | Data 6",
      "|===",
      "",
    }),
    t({
      "== Math Example",
      "",
      "An example of an inline mathematical formula:",
      "",
      "Math: ",
    }),
    i(3, "E = mc^2"),
    t({ "" }),
    t({
      "A block formula (if MathJax is enabled):",
      "",
      "[latexmath]",
      "++++",
    }),
    i(4, "\\sum_{i=1}^{n} i = \\frac{n(n+1)}{2}"),
    t({
      "++++",
      "",
    }),
  }),
}
