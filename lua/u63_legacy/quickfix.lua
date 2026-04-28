local M = {}

-- Quickfix export/import as JSON, portable across sessions (uses filenames instead of bufnr)
-- author: GPT-5 Thinking

local function canon_items(items)
  local out = {}
  for _, it in ipairs(items or {}) do
    local entry = {}

    -- Prefer absolute filename for portability
    local fname = it.filename
    if (not fname or fname == '') and it.bufnr and it.bufnr > 0 then
      local n = vim.api.nvim_buf_get_name(it.bufnr)
      if n and n ~= '' then
        fname = n
      end
    end
    if fname and fname ~= '' then
      entry.filename = vim.fn.fnamemodify(fname, ':p')
    end

    -- Core fields
    entry.lnum = it.lnum
    entry.col = it.col

    -- Optional fields (preserve if present)
    if it.end_lnum ~= nil then
      entry.end_lnum = it.end_lnum
    end
    if it.end_col ~= nil then
      entry.end_col = it.end_col
    end
    if it.vcol ~= nil then
      entry.vcol = it.vcol
    end
    if it.nr ~= nil then
      entry.nr = it.nr
    end
    if it.text ~= nil then
      entry.text = it.text
    end
    if it.type ~= nil then
      entry.type = it.type
    end
    if it.pattern ~= nil then
      entry.pattern = it.pattern
    end
    if it.module ~= nil then
      entry.module = it.module
    end
    if it.user_data ~= nil then
      entry.user_data = it.user_data
    end
    if it.valid ~= nil then
      entry.valid = it.valid
    end

    table.insert(out, entry)
  end
  return out
end

local function json_encode(tbl)
  if vim.json and vim.json.encode then
    return vim.json.encode(tbl)
  end
  return vim.fn.json_encode(tbl)
end

local function json_decode(str)
  if vim.json and vim.json.decode then
    return vim.json.decode(str)
  end
  return vim.fn.json_decode(str)
end

local function write_all(path, data)
  vim.fn.mkdir(vim.fn.fnamemodify(path, ':h'), 'p')
  local f = assert(io.open(path, 'w'))
  f:write(data)
  f:close()
end

local function read_all(path)
  local f = assert(io.open(path, 'r'))
  local s = f:read '*a'
  f:close()
  return s
end

local function qf_export(path)
  local qf = vim.fn.getqflist { items = 1, title = 1, context = 1 }
  local payload = {
    items = canon_items(qf.items),
    title = qf.title,
    context = qf.context,
    exported_at = os.date '!%Y-%m-%dT%H:%M:%SZ',
    cwd = vim.loop.cwd(),
  }
  write_all(path, json_encode(payload))
  vim.notify(
    ('Quickfix exported to %s (%d items)'):format(path, #payload.items)
  )
end

local function qf_import(path)
  local payload = json_decode(read_all(path))
  local items = payload.items or payload -- allow files that are just an array of items
  vim.fn.setqflist({}, 'r', {
    items = items,
    title = payload.title or ('Imported ' .. vim.fn.fnamemodify(path, ':t')),
    context = payload.context,
  })
  vim.cmd.copen()
  vim.notify(('Quickfix imported from %s (%d items)'):format(path, #items))
end

function M.pack()
  local packer = require 'packer'
  packer.use 'kevinhwang91/nvim-bqf'
end

function M.setup()
  vim.api.nvim_create_user_command('QfExport', function(opts)
    local path = opts.args
    if path == '' then
      local dir = vim.fn.stdpath 'data' .. '/quickfix'
      vim.fn.mkdir(dir, 'p')
      path = ('%s/qf-%s.json'):format(dir, os.date '%Y%m%d-%H%M%S')
    end
    qf_export(path)
  end, { nargs = '?', complete = 'file' })

  vim.api.nvim_create_user_command('QfImport', function(opts)
    local path = opts.args
    if path == '' then
      vim.notify('Usage: :QfImport /path/to/file.json', vim.log.levels.ERROR)
      return
    end
    qf_import(path)
  end, { nargs = 1, complete = 'file' })

  local bqf = require 'bqf'
  bqf.setup {
    preview = {
      auto_preview = false,
    },
  }
end

return M
