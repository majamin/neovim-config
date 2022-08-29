require("user.ensure_packer")

local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end

packer.startup(function(use)
  -- Deps
  use("https://github.com/wbthomason/packer.nvim")
  use("https://github.com/kyazdani42/nvim-web-devicons")
  use("https://github.com/nvim-lua/plenary.nvim")

  use("https://github.com/hrsh7th/nvim-cmp")
  use("https://github.com/hrsh7th/cmp-nvim-lsp")
  use("https://github.com/hrsh7th/cmp-nvim-lua") -- Hack Neovim
  use("https://github.com/saadparwaiz1/cmp_luasnip")
  use("https://github.com/hrsh7th/cmp-buffer")

  -- LSP
  use("https://github.com/neovim/nvim-lspconfig")
  use("https://github.com/onsails/lspkind-nvim")
  use("https://github.com/jose-elias-alvarez/null-ls.nvim") -- Magical unicorn
  use("https://github.com/williamboman/mason.nvim")
  use("https://github.com/williamboman/mason-lspconfig.nvim")
  use("https://github.com/glepnir/lspsaga.nvim")
  use("https://github.com/L3MON4D3/LuaSnip")
  use({
    "https://github.com/nvim-treesitter/nvim-treesitter",
    run = function()
      if pcall(require, "nvim-treesitter") then
        vim.cmd("TSUpdate")
      end
    end,
  })

  -- See everything, go fast
  use("https://github.com/ThePrimeagen/harpoon")
  use("https://github.com/nvim-telescope/telescope.nvim")
  use("https://github.com/nvim-telescope/telescope-file-browser.nvim")
  use("https://github.com/lewis6991/gitsigns.nvim")
  use("https://github.com/dinhhuy258/git.nvim")

  -- This is fine
  use("https://github.com/windwp/nvim-autopairs")
  use("https://github.com/ggandor/leap.nvim")
  use("https://github.com/numToStr/Comment.nvim")
  use("https://github.com/tpope/vim-surround")
  use("https://github.com/norcalli/nvim-colorizer.lua")
  use("https://github.com/vimwiki/vimwiki")

  -- Make your own color theme!
  use("rktjmp/lush.nvim")
end)
