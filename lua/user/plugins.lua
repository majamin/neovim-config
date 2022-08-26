require("user.ensure_packer")

local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end

packer.startup(function(use)
  use("https://github.com/wbthomason/packer.nvim") -- The package manager manages itself
  use("https://github.com/nvim-lua/plenary.nvim") -- Common utilities
  use("https://github.com/onsails/lspkind-nvim") -- LSP pictograms
  use("https://github.com/hrsh7th/cmp-buffer") -- Source buffer words in completion
  use("https://github.com/hrsh7th/cmp-nvim-lsp") -- Source nvim's LSP in completion
  use("https://github.com/hrsh7th/nvim-cmp") -- Completion
  use("https://github.com/neovim/nvim-lspconfig") -- Conveniently config LSPs
  use("https://github.com/jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server
  use("https://github.com/williamboman/mason.nvim")
  use("https://github.com/williamboman/mason-lspconfig.nvim")

  use("https://github.com/glepnir/lspsaga.nvim") -- LSP UIs
  use("https://github.com/L3MON4D3/LuaSnip")
  use({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    run = function()
      if pcall(require, "nvim-treesitter") then
        vim.cmd("TSUpdate")
      end
    end,
  })

  use("https://github.com/ThePrimeagen/harpoon")
  use("https://github.com/kyazdani42/nvim-web-devicons") -- File icons
  use("https://github.com/nvim-telescope/telescope.nvim")
  use("https://github.com/nvim-telescope/telescope-file-browser.nvim")
  use("https://github.com/windwp/nvim-autopairs")
  use("https://github.com/windwp/nvim-ts-autotag")
  use("https://github.com/norcalli/nvim-colorizer.lua")
  use("https://github.com/ggandor/leap.nvim")
  use("https://github.com/numToStr/Comment.nvim")
  use("https://github.com/tpope/vim-surround")

  use("https://github.com/lewis6991/gitsigns.nvim")
  use("https://github.com/dinhhuy258/git.nvim") -- For git blame & browse

  use("https://github.com/vimwiki/vimwiki")
end)
