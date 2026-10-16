-- Remove Neovim's default LSP maps that the gl maps below replace (grx, codelens run, stays)
for _, lhs in ipairs({ "grn", "grr", "gri", "grt", "gO" }) do
  pcall(vim.keymap.del, "n", lhs)
end
pcall(vim.keymap.del, { "n", "x" }, "gra")

local highlight_augroup = vim.api.nvim_create_augroup("user-lsp-highlight", { clear = true })
local highlight_method = vim.lsp.protocol.Methods.textDocument_documentHighlight

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local Snacks = require("snacks")
    local buf = event.buf

    -- Plain buffer-local keymaps (which-key still shows their desc).
    -- A server's on_attach runs after this, so it can replace any of them (see lsp/omnisharp.lua)
    local function map(lhs, rhs, desc, mode)
      vim.keymap.set(mode or "n", lhs, rhs, { buf = buf, desc = desc })
    end

    -- stylua: ignore start
    map("gd",  Snacks.picker.lsp_definitions,       "Goto Definition")      -- keeping to stay consistent with historical binds
    map("gD",  Snacks.picker.lsp_declarations,      "Goto Declaration")     -- keeping to stay consistent with historical binds
    map("gla", vim.lsp.buf.code_action,             "Code actions", { "n", "x" }) -- in visual mode, for the selection
    map("gli", Snacks.picker.lsp_implementations,   "Goto Implementation")
    map("gln", vim.lsp.buf.rename,                  "Rename")
    map("glr", Snacks.picker.lsp_references,        "References")
    map("gls", Snacks.picker.lsp_symbols,           "Symbols")
    map("glS", Snacks.picker.lsp_workspace_symbols, "Workspace Symbols")
    map("glt", Snacks.picker.lsp_type_definitions,  "Goto Type Definition")
    -- stylua: ignore end

    -- Highlight word under cursor
    -- Adapted from kickstart.nvim
    -- Improved with Claude Sonnet 4.6: highlighting _stays_ if you remain on the same object
    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if client and client:supports_method(highlight_method, buf) then
      -- Only reset this buffer's autocommands, so other buffers keep highlighting
      vim.api.nvim_clear_autocmds({ group = highlight_augroup, buf = buf })
      local hl_tick = 0

      local function cursor_in_refs()
        local ns = vim.api.nvim_get_namespaces()["nvim.lsp.references"]
        if not ns then
          return false
        end
        local pos = vim.api.nvim_win_get_cursor(0)
        local row, col = pos[1] - 1, pos[2]
        for _, mark in ipairs(vim.api.nvim_buf_get_extmarks(buf, ns, { row, 0 }, { row, -1 }, { details = true })) do
          local sc, ec = mark[3], mark[4].end_col
          if sc <= col and (ec == nil or col < ec) then
            return true
          end
        end
        return false
      end

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buf = buf,
        group = highlight_augroup,
        callback = function()
          hl_tick = hl_tick + 1
          local tick = hl_tick
          local params = vim.lsp.util.make_position_params(0, client.offset_encoding)
          client:request(highlight_method, params, function(err, result)
            if err or not result or hl_tick ~= tick then
              return
            end
            vim.lsp.util.buf_clear_references(buf)
            vim.lsp.util.buf_highlight_references(buf, result, client.offset_encoding)
          end, buf)
        end,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buf = buf,
        group = highlight_augroup,
        callback = function()
          if cursor_in_refs() then
            return
          end
          hl_tick = hl_tick + 1
          vim.lsp.util.buf_clear_references(buf)
        end,
      })
    end

    -- Toggle inlay hints
    if client and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlayHint, buf) then
      map("glh", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = buf }), { bufnr = buf })
      end, "Toggle Inlay [H]ints")
    end
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("user-lsp-detach", { clear = true }),
  callback = function(event)
    -- Keep highlighting if another attached client still provides it
    for _, c in ipairs(vim.lsp.get_clients({ bufnr = event.buf, method = highlight_method })) do
      if c.id ~= event.data.client_id then
        return
      end
    end
    vim.lsp.util.buf_clear_references(event.buf)
    vim.api.nvim_clear_autocmds({ group = highlight_augroup, buf = event.buf })
  end,
})

-- Enable every server that has a config file in lsp/ (stubs get their defaults from nvim-lspconfig)
-- (blink.cmp adds its completion capabilities by itself)
local servers = {}
for name, type in vim.fs.dir(vim.fn.stdpath("config") .. "/lsp") do
  if type == "file" and name:match("%.lua$") then
    table.insert(servers, name:sub(1, -5))
  end
end
vim.lsp.enable(servers)
