-- Install packer
local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
local is_bootstrap = false
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  vim.cmd([[packadd packer.nvim]])
end

local function get_config(name)
  return string.format('require("user/config/%s")', name)
end

require("packer").startup(function(use)
  use("https://github.com/lewis6991/impatient.nvim")
  use("https://github.com/wbthomason/packer.nvim")
  use({ "https://github.com/kyazdani42/nvim-web-devicons", config = get_config("web-devicons") })
  use("https://github.com/nvim-lua/plenary.nvim")

  -- LSP
  use({ "https://github.com/williamboman/mason.nvim", config = get_config("mason") })
  use("https://github.com/williamboman/mason-lspconfig.nvim")
  use({ "https://github.com/neovim/nvim-lspconfig", config = get_config("lspconfig") })
  use({ "https://github.com/onsails/lspkind-nvim", config = get_config("lspkind") })
  use({ "https://github.com/jose-elias-alvarez/null-ls.nvim", config = get_config("null-ls") }) -- Extends LSPs
  use({ "https://github.com/nvim-treesitter/nvim-treesitter", config = get_config("treesitter") })

  -- Completion
  use({ "https://github.com/hrsh7th/nvim-cmp", config = get_config("cmp") })
  use("https://github.com/hrsh7th/cmp-nvim-lsp")
  use("https://github.com/hrsh7th/cmp-nvim-lua") -- Hack Neovim
  use("https://github.com/saadparwaiz1/cmp_luasnip")
  use("https://github.com/hrsh7th/cmp-buffer")
  use("https://github.com/hrsh7th/cmp-path")
  use("https://github.com/rafamadriz/friendly-snippets")
  use({ "https://github.com/L3MON4D3/LuaSnip", config = get_config("luasnip") })

  -- See everything, go fast
  use({ "https://github.com/ThePrimeagen/harpoon", config = get_config("harpoon") })
  use({ "https://github.com/nvim-telescope/telescope.nvim", config = get_config("telescope") })
  use("https://github.com/nvim-telescope/telescope-file-browser.nvim")
  use({ "https://github.com/lewis6991/gitsigns.nvim", config = get_config("gitsigns") })
  use({ "https://github.com/jpalardy/vim-slime", config = get_config("slime") })
  use({ "https://github.com/tpope/vim-fugitive" })
  use({
    "https://github.com/sindrets/diffview.nvim",
    cmd = {
      "DiffviewOpen",
      "DiffviewClose",
      "DiffviewToggleFiles",
      "DiffviewFocusFiles",
    },
    config = get_config("diffview"),
  })

  -- Spicy
  use({ "https://github.com/folke/tokyonight.nvim", config = get_config("tokyonight") })
  use({ "https://github.com/norcalli/nvim-colorizer.lua", config = get_config("colorizer") })
  use({ "https://github.com/nvim-lualine/lualine.nvim", config = get_config("lualine") })
  use({ "https://github.com/lukas-reineke/indent-blankline.nvim", config = get_config("indent") })

  -- Butter
  use({
    "https://github.com/windwp/nvim-ts-autotag",
    config = get_config("ts-autotag"),
    ft = { "html", "tsx", "vue", "svelte", "php", "res" },
  })
  use({ "https://github.com/windwp/nvim-autopairs", config = get_config("autopairs") })
  use({ "https://github.com/numToStr/Comment.nvim", config = get_config("comment") })
  use("https://github.com/tpope/vim-surround")
  use({ "https://github.com/folke/which-key.nvim", config = get_config("which-key") })

  -- This is fine
  use({"https://github.com/famiu/bufdelete.nvim"})
  use({ "https://github.com/vimwiki/vimwiki", config = get_config("vimwiki") })
  use({
    "goolord/alpha-nvim",
    requires = { "kyazdani42/nvim-web-devicons" },
    config = get_config("alpha"),
  })

  if is_bootstrap then
    require("packer").sync()
  end
end)

if is_bootstrap then
  print("==================================")
  print("    Plugins are being installed")
  print("    Wait until Packer completes,")
  print("       then restart nvim")
  print("==================================")
  return
end

-- Automatically source and re-compile packer whenever you save this init.lua
local packer_group = vim.api.nvim_create_augroup("Packer", { clear = true })
vim.api.nvim_create_autocmd("BufWritePost", {
  command = "source <afile> | PackerCompile",
  group = packer_group,
  pattern = vim.fn.expand("$MYVIMRC"),
})
