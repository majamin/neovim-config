require("user.ensure_packer")

local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end

packer.startup(function(use)
  -- Better startup times
  use("https://github.com/lewis6991/impatient.nvim")

  -- Deps
  use("https://github.com/wbthomason/packer.nvim")
  use("https://github.com/kyazdani42/nvim-web-devicons")
  use("https://github.com/nvim-lua/plenary.nvim")

  use("https://github.com/hrsh7th/nvim-cmp")
  use("https://github.com/hrsh7th/cmp-nvim-lsp")
  use("https://github.com/hrsh7th/cmp-nvim-lua") -- Hack Neovim
  use("https://github.com/saadparwaiz1/cmp_luasnip")
  use("https://github.com/hrsh7th/cmp-buffer")
  use("https://github.com/rafamadriz/friendly-snippets")

  -- LSP
  use("https://github.com/neovim/nvim-lspconfig")
  use("https://github.com/onsails/lspkind-nvim")
  use("https://github.com/jose-elias-alvarez/null-ls.nvim") -- Magical unicorn
  use("https://github.com/williamboman/mason.nvim")
  use("https://github.com/williamboman/mason-lspconfig.nvim")
  use("https://github.com/glepnir/lspsaga.nvim")
  use("https://github.com/L3MON4D3/LuaSnip")
  use("https://github.com/nvim-treesitter/nvim-treesitter")
  use("https://github.com/nvim-treesitter/nvim-treesitter-textobjects")
  use("https://github.com/nvim-treesitter/playground")

  -- See everything, go fast
  use("https://github.com/ThePrimeagen/harpoon")
  use("https://github.com/nvim-telescope/telescope.nvim")
  use("https://github.com/nvim-telescope/telescope-file-browser.nvim")
  use("https://github.com/lewis6991/gitsigns.nvim")
  use("https://github.com/jpalardy/vim-slime")
  use({
    "TimUntersberger/neogit",
    requires = {
      "nvim-lua/plenary.nvim",
      {
        "sindrets/diffview.nvim",
        cmd = {
          "DiffviewOpen",
          "DiffviewClose",
          "DiffviewToggleFiles",
          "DiffviewFocusFiles",
        },
      },
    },
    cmd = "Neogit",
  })

  -- This is fine
  use("https://github.com/jacoborus/tender.vim")
  use("https://github.com/nvim-lualine/lualine.nvim")
  use("https://github.com/windwp/nvim-autopairs")
  use("https://github.com/lukas-reineke/indent-blankline.nvim")
  use("https://github.com/ggandor/leap.nvim")
  use("https://github.com/numToStr/Comment.nvim")
  use("https://github.com/tpope/vim-surround")
  use("https://github.com/norcalli/nvim-colorizer.lua")
  use("https://github.com/vimwiki/vimwiki")
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = function()
      require("alpha").setup(require("alpha.themes.dashboard").config)
    end,
  })
end)

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand("$MYVIMRC"),
})
