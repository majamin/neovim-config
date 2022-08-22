local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.init_lsp_saga({
  -- Options with default value
  -- "single" | "double" | "rounded" | "bold" | "plus"
  border_style = "single",
  --the range of 0 for fully opaque window (disabled) to 100 for fully
  --transparent background. Values between 0-30 are typically most useful.
  saga_winblend = 0,
  -- when cursor in saga window you config these to move
  move_in_saga = { prev = "<C-p>", next = "<C-n>" },
  -- diagnostic_header = { " ", " ", " ", "ﴞ " }, -- Let's get serious.
  diagnostic_header = { "😡", "😥", "😤", "😐" }, -- Silly? Yes.
  -- show diagnostic source
  show_diagnostic_source = true,
  -- add bracket or something with diagnostic source, just have 2 elements
  diagnostic_source_bracket = {},
  -- preview lines of lsp_finder and definition preview
  max_preview_lines = 10,
  -- use emoji lightbulb in default
  code_action_icon = "💡",
  -- if true can press number to execute the codeaction in codeaction window
  code_action_num_shortcut = true,
  -- same as nvim-lightbulb but async
  code_action_lightbulb = {
    enable = false, -- Disable for now. Do we need this?
    sign = true,
    enable_in_insert = true,
    sign_priority = 20,
    virtual_text = true,
  },
  -- finder icons
  finder_icons = {
    def = "",
    ref = "",
    link = "",
  },
  -- finder do lsp request timeout
  -- if your project big enough or your server very slow
  -- you may need to increase this value
  finder_request_timeout = 1500,
  finder_action_keys = {
    open = "o",
    vsplit = "s",
    split = "i",
    tabe = "t",
    quit = "<ESC>",
    scroll_down = "<C-f>",
    scroll_up = "<C-b>", -- quit can be a table
  },
  code_action_keys = {
    quit = "<ESC>",
    exec = "<CR>",
  },
  rename_action_quit = "<C-c>",
  rename_in_select = true,
  definition_preview_icon = "  ",
  -- show symbols in winbar must nightly
  symbol_in_winbar = {
    in_custom = false,
    enable = false,
    separator = " ",
    show_file = true,
    click_support = false,
  },
  -- show outline
  show_outline = {
    win_position = "right",
    --set special filetype win that outline window split.like NvimTree neotree
    -- defx, db_ui
    win_with = "",
    win_width = 30,
    auto_enter = true,
    auto_preview = true,
    virt_text = "┃",
    jump_key = "o",
    -- auto refresh when change buffer
    auto_refresh = true,
  },
  -- custom lsp kind
  -- usage { Field = 'color code'} or {Field = {your icon, your color code}}
  custom_kind = {},
  -- if you don't use nvim-lspconfig you must pass your server name and
  -- the related filetypes into this table
  -- like server_filetype_map = { metals = { "sbt", "scala" } }
  server_filetype_map = {
    typescript = "typescript",
  },
})

local opts = { noremap = true, silent = true }

-- Lsp finder find the symbol definition implement reference
-- when you use action in finder like open vsplit then your can
-- use <C-t> to jump back
vim.keymap.set("n", "gh", "<cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("v", "<leader>ca", "<cmd><C-U>Lspsaga range_code_action<CR>", opts)
vim.keymap.set("n", "gr", "<cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
vim.keymap.set("n", "<leader>cd", "<cmd>Lspsaga show_cursor_diagnostics<CR>", opts)
vim.keymap.set("n", "[e", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "]e", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
vim.keymap.set("n", "[E", function()
  require("lspsaga.diagnostic").goto_prev({ severity = vim.diagnostic.severity.ERROR })
end, opts)
vim.keymap.set("n", "]E", function()
  require("lspsaga.diagnostic").goto_next({ severity = vim.diagnostic.severity.ERROR })
end, opts)
vim.keymap.set("n", "<leader>o", "<cmd>LSoutlineToggle<CR>", opts)
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gs", "<Cmd>Lspsaga signature_help<CR>", opts)

-- OLD
vim.keymap.set("n", "]g", "<Cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("i", "[g", "<Cmd>Lspsaga signature_help<CR>", opts)
vim.keymap.set("n", "gp", "<Cmd>Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "gr", "<Cmd>Lspsaga rename<CR>", opts)
