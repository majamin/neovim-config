local status, indent = pcall(require, "indent_blankline")
if not status then
  return
end

-- Enable `lukas-reineke/indent-blankline.nvim`
-- See `:help indent_blankline.txt`
indent.setup({
  char = "┊",
  show_trailing_blankline_indent = false,
})
