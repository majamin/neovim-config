local M = {}

M.keymap = function(keys, func, desc)
  vim.keymap.set("n", keys, func, { desc = desc })
end

-- Safely set colorscheme
M.set_colorscheme = function()
  local colorscheme
  local colorscheme_table = require("user.opts").colorscheme
  local f = io.open(os.getenv("HOME") .. "/.config/zsh/set-light-theme", "r")
  if f ~= nil then
    io.close(f)
    colorscheme = colorscheme_table["light"]
  else
    colorscheme = colorscheme_table["dark"]
  end

  -- ---@diagnostic disable-next-line
  local ok, _ = pcall(vim.cmd, "colorscheme " .. colorscheme)
  if not ok then
    vim.cmd("colorscheme habamax")
    vim.print("Colorscheme not found: " .. colorscheme)
  end
end

-- Get all unique auxiliary tools
-- e.g. exclude "codespell" and "trim_whitespace"
M.list_aux_tools = function(tools)
  local list = {}
  for _, v in pairs(tools) do
    for _, f in pairs(v) do
      if f ~= "codespell" and f ~= "trim_whitespace" then
        table.insert(list, f)
      end
    end
  end
  return list
end

-- Custom folds
function _G.myfolds()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return line .. " ---------- " .. line_count .. " lines "
end

-- LSP callback function
M.lsp_callback = function(event)
  local builtin = require("telescope.builtin")
  local map = function(keys, func, desc)
    vim.keymap.set(
      "n",
      keys,
      func,
      { buffer = event.buf, desc = "LSP: " .. desc }
    )
  end

  -- OPTIONAL Turn off inline diagnostic virtual text - we're already using Trouble
  -- vim.diagnostic.config({ virtual_text = false })

  -- stylua: ignore start
  map("gd",         builtin.lsp_definitions,      "Goto Definition")
  map("gr",         builtin.lsp_references,       "Goto References")
  map("gI",         builtin.lsp_implementations,  "Goto Implementation")
  map("<leader>lD", builtin.lsp_type_definitions, "Type Definition")
  map("<leader>ld", builtin.lsp_document_symbols, "Document Symbols")
  map("<leader>lw", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")
  map("<leader>lr", vim.lsp.buf.rename,           "Rename")
  map("<leader>la", vim.lsp.buf.code_action,      "Code Action")
  map("K",          vim.lsp.buf.hover,            "Hover Documentation")
  map("gD",         vim.lsp.buf.declaration,      "Goto Declaration")
  -- stylua: ignore end

  local client = vim.lsp.get_client_by_id(event.data.client_id)
  if client and client.server_capabilities.documentHighlightProvider then
    local highlight_augroup =
      vim.api.nvim_create_augroup("user-lsp-highlight", { clear = false })
    vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.document_highlight,
    })

    vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
      buffer = event.buf,
      group = highlight_augroup,
      callback = vim.lsp.buf.clear_references,
    })

    vim.api.nvim_create_autocmd("LspDetach", {
      group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
      callback = function(event2)
        vim.lsp.buf.clear_references()
        vim.api.nvim_clear_autocmds({
          group = "user-lsp-highlight",
          buffer = event2.buf,
        })
      end,
    })
  end

  if
    client
    and client.server_capabilities.inlayHintProvider
    and vim.lsp.inlay_hint
  then
    map("<leader>lh", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
    end, "Toggle Inlay Hints")
  end
end

return M
