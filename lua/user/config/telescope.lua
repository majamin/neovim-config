local status, telescope = pcall(require, "telescope")
if not status then
  return
end
local actions = require("telescope.actions")
local builtin = require("telescope.builtin")

local compact_browser = require("user/functions").compact_browser

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
          ["<C-e>"] = fb_actions.create_from_prompt,
        },
        ["n"] = {
          -- your custom normal mode mappings
          ["x"] = fb_actions.remove,
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

vim.keymap.set("n", "<leader><leader>", function() builtin.resume() end, { desc = "Continue Finding ... " })
vim.keymap.set("n", "<leader>f", function() builtin.find_files({ no_ignore = false, hidden = true }) end, { desc = "Find Files" })
vim.keymap.set("n", "<leader>w", compact_browser, { desc = "Browse Files" })
vim.keymap.set("n", "<leader>o", function() builtin.oldfiles({ only_cwd = true }) end, { desc = "Old Files" })
vim.keymap.set("n", "<leader>g", function() builtin.live_grep() end, { desc = "Grep Files" })
vim.keymap.set("n", "<leader>b", function() builtin.buffers() end, { desc = "Find Buffers" })
vim.keymap.set("n", "<leader>h", function() builtin.help_tags() end, { desc = "Find Help Tags" })
vim.keymap.set("n", "<leader>k", function() builtin.keymaps() end, { desc = "Find Keymaps" })
vim.keymap.set("n", "<leader>e", function() builtin.diagnostics() end, { desc = "View LSP diagnostics" })
