local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local my_file_browser = require("user/functions").my_file_browser

-- local function telescope_buffer_dir()
--   return vim.fn.expand("%:p:h")
-- end
--
-- local function file_browser()
--   telescope.extensions.file_browser.file_browser({
--     path = "%:p:h",
--     cwd = telescope_buffer_dir(),
--     respect_gitignore = false,
--     hidden = true,
--     grouped = true,
--     previewer = false,
--     initial_mode = "normal",
--     layout_config = { height = 40 },
--   })
-- end
--
local fb_actions = require("telescope").extensions.file_browser.actions

telescope.setup({
  defaults = {
    mappings = {
      n = {
        ["q"] = actions.close,
      },
    },
  },
  extensions = {
    file_browser = {
      theme = "dropdown",
      -- disables netrw and use telescope-file-browser in its place
      hijack_netrw = true,
      mappings = {
        -- your custom insert mode mappings
        ["i"] = {
          ["<C-w>"] = function()
            vim.cmd("normal vbd")
          end,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["N"] = fb_actions.create,
          ["h"] = fb_actions.goto_parent_dir,
          ["l"] = function()
            vim.cmd('execute "normal \\<cr>"')
          end,
        },
      },
    },
  },
})

telescope.load_extension("file_browser")

vim.keymap.set("n", ";;", function()
  builtin.resume()
end)
vim.keymap.set("n", ";f", function()
  builtin.find_files({
    no_ignore = false,
    hidden = true,
  })
end)
vim.keymap.set("n", ";g", function()
  builtin.live_grep()
end)
-- stop myself from being sloppy: if I need other files, use tmux
vim.keymap.set("n", ";o", function()
  builtin.oldfiles({ only_cwd = true })
end)
vim.keymap.set("n", ";b", function()
  builtin.buffers()
end)
vim.keymap.set("n", ";h", function()
  builtin.help_tags()
end)
vim.keymap.set("n", ";k", function()
  builtin.keymaps()
end)
vim.keymap.set("n", ";e", function()
  builtin.diagnostics()
end)
vim.keymap.set("n", ";w", my_file_browser)
