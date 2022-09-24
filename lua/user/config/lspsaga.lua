local status, saga = pcall(require, "lspsaga")
if not status then
  return
end

saga.init_lsp_saga({
  code_action_lightbulb = {
    enable = false, -- I wish I could turn this off only in the gutter
  },
})
