# HELP

## What do I do with this repo?

You can download or clone this repo to your [config folder](https://vi.stackexchange.com/a/12596).

|           |                         |
| --------- | ----------------------- |
| `Unix`    | `~/.config/nvim`        |
| `Windows` | `~/AppData/Local/nvim`* |

(*) On Windows, it's better to run Neovim under WSL for a nicer experience

## First few runs

After you've cloned this repo, and put it in the appropriate location,
it's time to start Neovim.

- On first run, `Packer` is installed and plugins are installed.
- Restart Neovim. Treesitter will install a few languages in the background.
- Use `;w` to browse files and `;f` to find files.
- Editing `lua/user/user-conf.lua` should be enough to get you started (no need to dig into other files, but you're more than welcome to!)

## Trouble? Tips?

### I'm seeing lots of errors, even after a few Neovim restarts.

Run `:checkhealth` and pay attention to any important messages there.

### How do I add an LSP client to my config? Formatters, Linters?

- LSP clients: add them to the list in `lua/user/user-conf.lua` and restart Neovim (they will be installed).
- Formatters, Debuggers, etc: add them to `sources` in `lua/user/config/null-ls.lua`

Unlike LSP clients, you will need to **manually install your Formatters, etc.**
(e.g. something like `npm install -g prettier`).

### Completions, autoformatting, etc. aren't working.

Read the next section.

### How do I see if my LSP client (including `null-ls`) is attached and running?

Open `:LspInfo`.

## Formatting? Autocompletion? Bling?

I hate distractions, so the default config is "quiet" by default.
To this end, (1) key hints (`which-key`), (2) autocompletion, and (3) formatting-on-save are silenced.
These can be individually toggled in `lua/user/user-conf.lua`.

## Keybindings

Press `;k` to telescope them, or run `:WhichKey`.
I've tried to leave as many default Vim bindings as their original.

A short summary of notable bindings / remaps:

- Browse files with `;w` browse files
- Find files with `;f`
- Grep files with `;g`
- Browse open buffers with `;b`
- `<C-h>` opens Harpoon, `<leader>a` adds a file to the quick menu
- `<TAB>` goes to next Harpoon file, `<S-TAB>` does the reverse
- `<Backspace>` switch to alternate buffer (quick switch)
- `<C-w>b` deletes the buffer
- `<C-n>` and `<C-p>` navigate a completion list (`<C-n>` also opens completion), `<C-y>` confirms
- `<C-l>f` to format

## Inspirations for this config

[Here's a really nice video](https://www.youtube.com/watch?v=GznmPACXBlY) that shows what using Neovim looks like.

_Repos_:

- [Neovim Kickstart](https://github.com/nvim-lua/kickstart.nvim)
- [Craftzdog's Neovim Config](https://github.com/craftzdog/dotfiles-public/tree/master/.config/nvim)
- [Allaman's Neovim Config](https://github.com/Allaman/nvim)
- [LSP-config Author's Config](https://github.com/wbthomason/dotfiles/tree/linux/neovim/.config/nvim)
