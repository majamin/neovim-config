-- Installs Packer as the package manager

local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({
    "git",
    "clone",
    "https://github.com/wbthomason/packer.nvim",
    install_path,
  })
  print("Installing packer...")
  vim.api.nvim_command("packadd packer.nvim")
  print("Packer installed. Please restart Neovim and run PackerSync.")
end

local status, packer = pcall(require, "packer")
if not status then
  print("Packer is not installed")
  return
end

packer.init({
  enable = true, -- enable profiling via :PackerCompile profile=true
  threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
  max_jobs = 20, -- Set to 20 in order to prevent PackerSync form being "stuck"
  display = {
    open_fn = function()
      return require("packer.util").float({ border = "rounded" })
    end,
  },
  -- log = { level = "debug" },
  log = { level = "warn" },
})
