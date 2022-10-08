local g = vim.g
g.vimwiki_global_ext = 0 -- Don't vimwiki every goddamn md file, please
g.vimwiki_url_maxsave = 0 -- Don't shorten URL so you can plumb links
-- g.vimwiki_ext2syntax = {'.Rmd': 'markdown', '.rmd': 'markdown','.md': 'markdown', '.markdown': 'markdown', '.mdown': 'markdown'}
vim.g.vimwiki_list = { { path = os.getenv("ONEDRIVE") .. "/Projects/notes" } }
