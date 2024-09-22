local M = {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true }, -- NOTE: Must be loaded before dependants
    "williamboman/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    "folke/trouble.nvim",
    {
      "folke/lazydev.nvim",
      ft = "lua",
    },
  },
  event = { "BufReadPost", "BufNewFile" },
  cmd = { "LspInfo", "LspInstall", "LspUninstall" },
}

M.config = function()
  local servers = require("user.opts").servers
  local servers_already_installed = require("user.opts").servers_already_installed

  vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("user-lsp-attach", { clear = true }),
    callback = function(event)
      local map = function(keys, func, desc)
        vim.keymap.set(
          "n",
          keys,
          func,
          { buffer = event.buf, desc = "LSP: " .. desc }
        )
      end

      map("gd", require("telescope.builtin").lsp_definitions, "Goto Definition")
      map("gr", require("telescope.builtin").lsp_references, "Goto References")
      map(
        "gI",
        require("telescope.builtin").lsp_implementations,
        "Goto Implementation"
      )
      map(
        "<leader>D",
        require("telescope.builtin").lsp_type_definitions,
        "Type Definition"
      )
      map(
        "<leader>ld",
        require("telescope.builtin").lsp_document_symbols,
        "Document Symbols"
      )
      map(
        "<leader>lw",
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        "Workspace Symbols"
      )
      map("<leader>lr", vim.lsp.buf.rename, "Rename")
      map("<leader>la", vim.lsp.buf.code_action, "Code Action")
      map("K", vim.lsp.buf.hover, "Hover Documentation")
      map("gD", vim.lsp.buf.declaration, "Goto Declaration")

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
          group = vim.api.nvim_create_augroup(
            "user-lsp-detach",
            { clear = true }
          ),
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
        end, "[T]oggle Inlay [H]ints")
      end
    end,
  })

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    require("cmp_nvim_lsp").default_capabilities()
  )

  require("mason").setup()

  local ensure_installed = vim.tbl_keys(servers or {})
  vim.list_extend(ensure_installed, {
    "stylua", -- Used to format Lua code
  })
  require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

  -- LSP settings (for overriding per client)
  local handlers = {
    ["textDocument/hover"] = vim.lsp.with(
      vim.lsp.handlers.hover,
      { border = "rounded" }
    ),
    ["textDocument/signatureHelp"] = vim.lsp.with(
      vim.lsp.handlers.signature_help,
      { border = "rounded" }
    ),
  }

  require("mason-lspconfig").setup({
    handlers = {
      function(server_name)
        local server = servers[server_name] or {}
        -- This handles overriding only values explicitly passed
        -- by the server configuration above. Useful when disabling
        -- certain features of an LSP (for example, turning off formatting for tsserver)
        server.capabilities = vim.tbl_deep_extend(
          "force",
          {},
          capabilities,
          server.capabilities or {}
        )
        server.handlers =
          vim.tbl_deep_extend("force", {}, handlers, server.handlers or {})
        require("lspconfig")[server_name].setup(server)
      end,
    },
  })

  -- These servers have not been installed by mason-tool-installer.
  -- Here we set them up manually.
  local servers_setup_only = require("user.opts").servers_setup_only
  for _, server_name in ipairs(vim.tbl_keys(servers_setup_only)) do
    vim.print("Setting up server: " .. server_name)
    local server = servers_setup_only[server_name] or {}
    server.capabilities = vim.tbl_deep_extend(
      "force",
      {},
      capabilities,
      server.capabilities or {}
    )
    server.handlers =
      vim.tbl_deep_extend("force", {}, handlers, server.handlers or {})
    require("lspconfig")[server_name].setup(server)
  end


end

return M
