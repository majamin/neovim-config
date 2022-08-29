local status, colorizer = pcall(require, "colorizer")
if not status then
  return
end

vim.cmd('set termguicolors')

colorizer.setup({
  "*",
})
