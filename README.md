# What is this?

This is a configuration repo for [Neovim](https://neovim.io/).
You can download or clone this repo to your [config folder](https://vi.stackexchange.com/a/12596).

[Here's a really nice video](https://www.youtube.com/watch?v=GznmPACXBlY) that shows what using Neovim looks like.

# Neovim Config

_Inspirations_:

- [Craftzdog's Neovim Config](https://github.com/craftzdog/dotfiles-public/tree/master/.config/nvim)
- [Allaman's Neovim Config](https://github.com/Allaman/nvim)
- [Author of LSP-config Neovim Config](https://github.com/wbthomason/dotfiles/tree/linux/neovim/.config/nvim)

# First Run

On first run, Neovim will install `Packer` but not any of the plugins.
Restart Neovim and run `:PackerSync`. Error messages on this run are normal.
Restart Neovim one more time. Run `:checkhealth` and pay attention to any important messages there.
Edit `user-conf.lua` to your liking and you should be good to go!

# Quick use guide

- `;k` for key bindings
- `;h` for help topics
- `;f` to find files
- `;w` to browse files
- `<F3>` and `<F4>` toggles spelling for English and _basic_ English (enables a kind of "check if my document is way too complicated")
- `<Ctrl-b>` closes buffer
- `<Ctrl-q>` closes window
- `<Tab>`, `<Shift-Tab>` to switch between buffers
- `tt` opens Harpoon (pressing 1, 2, etc. opens that file)
- `ta` adds the buffer filepath to the Harpoon list
- `t1`, `t2` opens the first, or second file, etc.
- `<S-l>` and `<S-h>` initiates [leap](https://github.com/ggandor/leap.nvim) (I insist on using `s` and `S` as per the original Vim bindings)

# A little bit more in-depth

- Use `user-conf.lua` for basic settings
- Surround with Tim Pope's vim-surround
- Telescope file browser uses Vim keys (hjkl) to move around/open
