local status, ts = pcall(require, "nvim-treesitter.configs")
if not status then
  return
end

-- See https://github.com/nvim-treesitter/nvim-treesitter#available-modules
ts.setup({
  auto_install = true, -- automatically install missing parsers
  highlight = { enable = true },
  endwise = { enable = true },
  indent = { enable = true },
  autopairs = { enable = true },
})
