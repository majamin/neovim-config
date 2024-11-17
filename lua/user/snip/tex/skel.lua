local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local ai = require("luasnip.nodes.absolute_indexer")
local events = require("luasnip.util.events")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local autosnippet =
  ls.extend_decorator.apply(s, { snippetType = "autosnippet" })

local function copy(args)
  return args[1]
end

return {
  s("skel", {
    t({
      "\\documentclass[a4paper,12pt]{article}",
      "",
      "\\usepackage{amsmath}",
      "\\usepackage{amssymb}",
      "\\usepackage{booktabs}",
      "\\usepackage{geometry}",
      "\\geometry{margin=1in}",
      "",
      "\\title{",
    }),
    i(1, "Title Here"),
    t("}"),
    t({ "", "\\author{" }),
    i(2, "Author Name"),
    t("}"),
    t({ "", "\\date{\\today}", "", "\\begin{document}", "", "\\maketitle", "" }),
    t({ "", "\\section{Introduction}", "" }),
    t({ "This is a basic introduction. Write your content here.", "", "" }),
    t({ "\\section{Table Example}", "" }),
    t({ "Below is an example of a simple table:", "" }),
    t({
      "\\begin{table}[h!]",
      "    \\centering",
      "    \\begin{tabular}{|c|c|c|}",
      "    \\hline",
      "    Column 1 & Column 2 & Column 3 \\\\",
      "    \\hline",
      "    Data 1 & Data 2 & Data 3 \\\\",
      "    \\hline",
      "    Data 4 & Data 5 & Data 6 \\\\",
      "    \\hline",
      "    \\end{tabular}",
      "    \\caption{A simple table}",
      "    \\label{tab:example}",
      "\\end{table}",
      "",
    }),
    t({ "\\section{Math Example}", "" }),
    t({ "Here's an example of a mathematical formula:", "" }),
    t({
      "\\begin{equation}",
      "    E = mc^2",
      "\\end{equation}",
      "",
    }),
    t({ "And a summation example:", "" }),
    t({
      "\\begin{equation}",
      "    \\sum_{i=1}^{n} i = \\frac{n(n+1)}{2}",
      "\\end{equation}",
      "",
    }),
    t({ "\\end{document}" }),
  }),
}
