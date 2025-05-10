vim.api.nvim_create_user_command("LatexBuild", function()
  local file = vim.fn.expand("%:p") -- full path to current file
  local cmd = string.format(
    [[tmux new-window 'echo %s | entr -c sh -c "latexmk -shell-escape -lualatex %s && latexmk -c -silent %s"' ]],
    vim.fn.shellescape(file),
    vim.fn.shellescape(file),
    vim.fn.shellescape(file)
  )
  vim.fn.system(cmd)
end, {})

vim.api.nvim_create_user_command("AdocBuildALL", function()
  local cmd = "fd '\\.adoc$' ./src | entr -c sh -c 'make -f ~/.local/src/simple-asciidoctor-template/simple.mk'"
  vim.fn.system(cmd)
end, {})

vim.api.nvim_create_user_command("AdocBuildHTML", function()
  local file = vim.fn.expand("%:p") -- full path to current file
  local cmd = string.format(
    [[tmux new-window 'echo %s | entr -c sh -c "make -f ~/.local/src/simple-asciidoctor-template/simple.mk single-html FILE=%s"' ]],
    vim.fn.shellescape(file),
    vim.fn.shellescape(file)
  )
  vim.fn.system(cmd)
end, {})

vim.api.nvim_create_user_command("AdocBuildREVEAL", function()
  local file = vim.fn.expand("%:p") -- full path to current file
  local cmd = string.format(
    [[tmux new-window 'echo %s | entr -c sh -c "make -f ~/.local/src/simple-asciidoctor-template/simple.mk single-reveal FILE=%s"' ]],
    vim.fn.shellescape(file),
    vim.fn.shellescape(file)
  )
  vim.fn.system(cmd)
end, {})

vim.api.nvim_create_user_command("AdocBuildPDF", function()
  local file = vim.fn.expand("%:p") -- full path to current file
  local cmd = string.format(
    [[tmux new-window 'echo %s | entr -c sh -c "make -f ~/.local/src/simple-asciidoctor-template/simple.mk single-pdf FILE=%s"' ]],
    vim.fn.shellescape(file),
    vim.fn.shellescape(file)
  )
  vim.fn.system(cmd)
end, {})
