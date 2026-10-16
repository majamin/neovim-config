local M = {}

-- Folding aesthetic
function _G.myfolds()
  local line = vim.fn.getline(vim.v.foldstart)
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  return line .. " ·········· " .. line_count .. " lines "
end

-- Is the location list of the current window open?
function M.loclist_is_open()
  return vim.fn.getloclist(0, { winid = 0 }).winid ~= 0
end

-- Save and run ~/.local/bin/compiler on the current file in the background.
-- Errors go to the quickfix list so :cnext jumps through them.
function M.compile()
  vim.cmd("silent write")
  local file = vim.api.nvim_buf_get_name(0)
  local start = vim.uv.hrtime()
  vim.system({ "compiler", file }, { text = true }, function(res)
    vim.schedule(function()
      local secs = (vim.uv.hrtime() - start) / 1e9
      if res.code == 0 then
        vim.notify(("Compiled in %.1fs"):format(secs))
        return
      end
      local lines = vim.split(res.stderr .. res.stdout, "\n", { trimempty = true })
      vim.fn.setqflist({}, " ", { title = "compiler", lines = lines })
      vim.cmd("copen")
      vim.notify("Compile failed", vim.log.levels.ERROR)
    end)
  end)
end

-- One entr watcher per file, so <leader>cw toggles it on and off.
local watchers = {}

-- Recompile the current file whenever it, or any file of the same type in the
-- project, changes. Watching the siblings catches edits to imported files.
function M.compile_watch()
  local file = vim.api.nvim_buf_get_name(0)
  if watchers[file] then
    watchers[file]:kill("sigterm")
    watchers[file] = nil
    vim.notify("Stopped watching " .. vim.fs.basename(file))
    return
  end

  local dir = vim.fs.dirname(file)
  local root = vim.fs.root(file, ".git") or dir
  local ext = file:match("%.([^.]+)$") or ""
  local deps = vim.fs.find(function(name, path)
    return name:match("%." .. vim.pesc(ext) .. "$") and not path:match("/build")
  end, { path = root, type = "file", limit = math.huge })

  vim.cmd("silent write")
  local function report(_, data)
    if data and data ~= "" then
      vim.schedule(function() vim.notify(vim.trim(data), vim.log.levels.WARN) end)
    end
  end
  -- -n because entr has no terminal here
  watchers[file] = vim.system({ "entr", "-n", "compiler", file }, {
    stdin = table.concat(deps, "\n") .. "\n",
    stderr = report,
  }, function()
    watchers[file] = nil
  end)
  vim.notify(("Watching %d .%s file(s) for %s"):format(#deps, ext, vim.fs.basename(file)))
end

vim.api.nvim_create_autocmd("VimLeavePre", {
  callback = function()
    for _, w in pairs(watchers) do
      w:kill("sigterm")
    end
  end,
})

return M
