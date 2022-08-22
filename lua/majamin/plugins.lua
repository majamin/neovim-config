local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end

vim.cmd([[packadd packer.nvim]])

packer.startup(function(use)
  use("wbthomason/packer.nvim") -- The package manager manages itself
  use("nvim-lua/plenary.nvim") -- Common utilities
  use("onsails/lspkind-nvim") -- LSP pictograms
  use("hrsh7th/cmp-buffer") -- Source buffer words in completion
  use("hrsh7th/cmp-nvim-lsp") -- Source nvim's LSP in completion
  use("hrsh7th/nvim-cmp") -- Completion
  use("neovim/nvim-lspconfig") -- Conveniently config LSPs
  use("jose-elias-alvarez/null-ls.nvim") -- Use Neovim as a language server
  use("MunifTanjim/prettier.nvim") -- Prettier plugin
  use("williamboman/mason.nvim")
  use("williamboman/mason-lspconfig.nvim")

  use("glepnir/lspsaga.nvim") -- LSP UIs
  use("L3MON4D3/LuaSnip")
  use({
    "nvim-treesitter/nvim-treesitter",
    run = function()
      if pcall(require, "nvim-treesitter") then
        vim.cmd("TSUpdate")
      end
    end,
  })

  use("ThePrimeagen/harpoon")
  use("kyazdani42/nvim-web-devicons") -- File icons
  use("nvim-telescope/telescope.nvim")
  use("nvim-telescope/telescope-file-browser.nvim")
  use("windwp/nvim-autopairs")
  use("windwp/nvim-ts-autotag")
  use("norcalli/nvim-colorizer.lua")
  use("ggandor/leap.nvim")
  use("numToStr/Comment.nvim")
  use("tpope/vim-surround")

  use("lewis6991/gitsigns.nvim")
  use("dinhhuy258/git.nvim") -- For git blame & browse
end)
