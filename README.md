# Yet Another Neovim Config

Hi. This is my config for [Neovim](http://neovim.io).

# Get Started

Keybindings are very personal, and my config is no different.
Non-plugin keys are (mostly) in `lua/user/keys.lua`, but some are scattered elsewhere for functionality.

* **Browse Files**: Telescope (`;;`, `;f`, etc.), `-` for browsing with [Oil](https://github.com/stevearc/oil.nvim).
* **Buffers, etc.**: `<C-w>b` to delete a buffer and `<TAB>` to switch buffers. Window-switch keys are unaltered from the original.
* **Customizing**: Add/change options, LSP configs, formatters in `lua/user/init.lua`.
* **LSP bindings**: `lua/plugins/lsp.lua` has some bindings for LSPs.
* Use `:W` to explore all bindings.

There are no extras here - there's only one installed colorscheme [Tokyo Night](https://github.com/folke/tokyonight.nvim),
no mouse, no smooth scrolling to keep things snappy and strict.
