local M = {
  "jakewvincent/mkdnflow.nvim",
}

M.config = function()
  require("mkdnflow").setup({
    mappings = {
      MkdnEnter = { { 'n', 'v' }, '<CR>' },
      MkdnTab = false,
      MkdnSTab = false,
      MkdnNextLink = false, -- was <TAB>
      MkdnPrevLink = false, -- was <S-TAB>
      MkdnNextHeading = { 'n', ']]' },
      MkdnPrevHeading = { 'n', '[[' },
      MkdnGoBack = { 'n', '<BS>' },
      MkdnGoForward = false,
      MkdnCreateLink = false,                                      -- see MkdnEnter
      MkdnCreateLinkFromClipboard = false,
      MkdnFollowLink = false,                                      -- see MkdnEnter
      MkdnDestroyLink = { 'n', '<M-CR>' },
      MkdnTagSpan = { 'v', '<M-CR>' },
      MkdnMoveSource = { 'n', '<F2>' },
      MkdnYankAnchorLink = { 'n', 'yaa' },
      MkdnYankFileAnchorLink = { 'n', 'yfa' },
      MkdnIncreaseHeading = false,
      MkdnDecreaseHeading = false,
      MkdnToggleToDo = { { 'n', 'v' }, '<C-Space>' },
      MkdnNewListItem = false,
      MkdnNewListItemBelowInsert = { 'n', 'o' },
      MkdnNewListItemAboveInsert = { 'n', 'O' },
      MkdnExtendList = false,
      MkdnUpdateNumbering = { 'n', '<leader>nn' },
      MkdnTableNextCell = { 'i', '<Tab>' },
      MkdnTablePrevCell = { 'i', '<S-Tab>' },
      MkdnTableNextRow = false,
      MkdnTablePrevRow = { 'i', '<M-CR>' },
      MkdnTableNewRowBelow = { 'n', '<leader>ir' },
      MkdnTableNewRowAbove = { 'n', '<leader>iR' },
      MkdnTableNewColAfter = { 'n', '<leader>ic' },
      MkdnTableNewColBefore = { 'n', '<leader>iC' },
      MkdnFoldSection = { 'n', '<leader>f' },
      MkdnUnfoldSection = { 'n', '<leader>F' }
    }
  })
end

return M
