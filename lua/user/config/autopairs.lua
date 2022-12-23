local status, autopairs = pcall(require, "nvim-autopairs")
if not status then
  return
end

autopairs.setup({
  check_ts = true,
  ignored_next_char = "[%w%.]",
  enable_check_bracket_line = false,
})
