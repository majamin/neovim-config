local M = {
  "echasnovski/mini.nvim",
  version = "*",
}

M.config = function()
  local starter = require("mini.starter")
  local mini = require("mini.sessions")
  mini.setup()
  starter.setup({
    evaluate_single = true,
    items = {
      starter.sections.builtin_actions(),
      starter.sections.recent_files(6, true),
      starter.sections.recent_files(6, false),
      starter.sections.sessions(3, true),
    },
    content_hooks = {
      starter.gen_hook.adding_bullet(),
      starter.gen_hook.indexing("all", { "Builtin actions" }),
      starter.gen_hook.padding(3, 2),
    },
  })
end

return M
