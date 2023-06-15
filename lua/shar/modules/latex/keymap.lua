--[[
-- Handy keymaps for editing LaTeX documents.
--]]
local vim = vim
local api = vim.api
local keymap = vim.keymap
local fn = vim.fn

local namespace = api.nvim_create_namespace('LatexKeymap')

local function increment_col(line, col)
  local text_after = unpack(api.nvim_buf_get_text(0, line, col, line, col + 4, {}))
  local bytes_in_char = vim.str_byteindex(text_after, 1)
  return col + bytes_in_char
end

local function get_visual_selection()
  local begin_line, begin_col = unpack(fn.getpos("v"), 2)
  local end_line, end_col = unpack(fn.getpos("."), 2)
  if begin_line > end_line or begin_line == end_line and begin_col > end_col then
    begin_line, end_line = end_line, begin_line
    begin_col, end_col = end_col, begin_col
  end
  begin_line, begin_col = begin_line - 1, begin_col - 1
  end_line, end_col = end_line - 1, end_col - 1
  end_col = increment_col(end_line, end_col)
  return begin_line, begin_col, end_line, end_col
end

local function wrap(prefix, suffix)
  local begin_line, begin_col, end_line, end_col = get_visual_selection()
  local end_mark = api.nvim_buf_set_extmark(0, namespace, end_line, end_col, {})
  api.nvim_buf_set_text(0, end_line, end_col, end_line, end_col, { suffix })
  api.nvim_buf_set_text(0, begin_line, begin_col, begin_line, begin_col, { prefix })
  end_line, end_col = unpack(
    api.nvim_buf_get_extmark_by_id(0, namespace, end_mark, {})
  )
  api.nvim_buf_del_extmark(0, namespace, end_mark)
  api.nvim_win_set_cursor(0, { end_line + 1, end_col })
  api.nvim_input '<Esc>'
  return end_line, end_col
end

local function wrap_command(command)
  return wrap('\\' .. command .. '{', '}')
end

local function wrap_underbrace()
  local line, col = wrap('\\underbrace{', '}_{}')
  api.nvim_win_set_cursor(0, { line + 1, col - 1 })
  vim.cmd 'startinsert'
end

local function wrap_delimiter(open, close)
  return wrap('\\left' .. open .. ' ', ' \\right' .. close)
end

local function setup_wrap_keymaps()
  keymap.set('x', '<Leader>bf', function()
    wrap_command('textbf')
  end, {
    buffer = true,
    desc = 'Wrap a \\textbf command around a visual selection'
  })
  keymap.set('x', '<Leader>it', function()
    wrap_command('textit')
  end, {
    buffer = true,
    desc = 'Wrap a \\textit command around a visual selection',
  })
  keymap.set('x', '<Leader>u', wrap_underbrace, {
    buffer = true,
    desc = 'Wrap an \\underbrace around a visual selection',
  })
  keymap.set('x', '<Leader>sb', function()
    wrap_delimiter('(', ')')
  end, {
    buffer = true,
    desc = 'Wrap a \\left( .. \\right) delimiter around a visual selection',
  })
  keymap.set('x', '<Leader>sB', function()
    wrap_delimiter('\\{', '\\}')
  end, {
    buffer = true,
    desc = 'Wrap a \\left\\{ .. \\right\\} delimiter around a visual selection',
  })
  keymap.set('x', '<Leader>sa', function()
    wrap_delimiter('|', '|')
  end, {
    buffer = true,
    desc = 'Wrap a \\left| .. \\right| delimiter around a visual selection',
  })
  keymap.set('x', '<Leader>sq', function()
    wrap_delimiter('[', ']')
  end, {
    buffer = true,
    desc = 'Wrap a \\left[ .. \\right] delimiter around a visual selection',
  })
  keymap.set('x', '<Leader>sn', function()
    wrap_delimiter('\\|', '\\|')
  end, {
    buffer = true,
    desc = 'Wrap a \\left\\| .. \\right\\| delimiter around a visual selection',
  })
  keymap.set('x', '<Leader>sQ', function()
    wrap('<<', '>>')
  end, {
    buffer = true,
    desc = 'Wrap a quote << .. >> around a visual selection',
  })
end

local function setup_keymaps()
  setup_wrap_keymaps()

  -- Integration with inkscape-figures CLI tool
  keymap.set('i', '<C-f>',
    "<Esc>: silent exec '.!~/.local/bin/inkscape-figures create \"'.getline('.').'\" \"'.b:vimtex.root.'/figures/\"'<CR><CR>:w<CR>",
    { buffer = true }
  )
  keymap.set('n', '<C-f>',
    ": silent exec '!~/.local/bin/inkscape-figures edit \"'.b:vimtex.root.'/figures/\" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>",
    { buffer = true }
  )
end

local augroup = api.nvim_create_augroup("LatexKeymap", {})

api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
  pattern = '*.tex',
  callback = setup_keymaps,
  group = augroup,
})
