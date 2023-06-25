--[[
-- Handy keymaps for editing LaTeX documents.
--]]
local vim = vim
local api = vim.api
local keymap = vim.keymap
local fn = vim.fn
local ui = vim.ui
local b = vim.b

local latex_keymap = {}

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
  return wrap(string.format('\\%s{', command), '}')
end

local function wrap_underbrace()
  local line, col = wrap('\\underbrace{', '}_{}')
  api.nvim_win_set_cursor(0, { line + 1, col - 1 })
  vim.cmd 'startinsert'
end

local function wrap_delimiter(open, close)
  return wrap(
    string.format('\\left%s ', open),
    string.format(' \\right%s', close)
  )
end

local function setup_wrap_keymaps()
  keymap.set('x', '<Leader>bf', function()
    wrap_command('textbf')
  end, {
    buffer = true,
    desc = 'Wrap a \\textbf command around a visual selection'
  })
  keymap.set('x', '<Leader>em', function()
    wrap_command('emph')
  end, {
    buffer = true,
    desc = 'Wrap a \\emph command around a visual selection',
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

-- Integration with inkscape-figures CLI tool (by Gilles Castel)

local function get_figures_dir()
  return b.vimtex.root .. '/figures/'
end

local function inkscape_figures_watch()
  vim.system {
    latex_keymap.inkscape_figures,
    'watch',
  }
end

local function prune_figure_name(figure_name)
  return figure_name:lower():gsub(' ', '_')
end

local function ask_new_figure_name()
  local figure_name
  ui.input({ prompt = 'Create New Figure: ' }, function(input)
    figure_name = input
  end)
  if not figure_name then
    return
  end
  return prune_figure_name(figure_name)
end

local function paste_include_figure_snippet(figure_name)
  local line = api.nvim_win_get_cursor(0)[1]
  api.nvim_buf_set_lines(0, line, line, false, {
    '\\begin{figure}[ht]',
    ' \\centering',
    ' \\incfig[1.0]{' .. figure_name .. '}',
    ' \\caption{' .. figure_name .. '}',
    ' \\label{fig:' .. figure_name .. '}',
    '\\end{figure}',
  })
end

local function inkscape_figures_create()
  inkscape_figures_watch()
  local figure_name = ask_new_figure_name()
  if not figure_name then
    return
  end
  print('New Figure:', figure_name)
  paste_include_figure_snippet(figure_name)
  vim.system {
    latex_keymap.inkscape_figures,
    'create',
    figure_name,
    get_figures_dir(),
  }
end

local function inkscape_figures_open()
  inkscape_figures_watch()
  vim.system {
    latex_keymap.inkscape_figures,
    'edit',
    get_figures_dir(),
  }
end

local function setup_inkscape_figures_keymaps()
  keymap.set('n', '<Leader>lfn',
    inkscape_figures_create,
    {
      buffer = true,
      desc = 'Create a new figure with inkscape_figures tool',
    }
  )
  keymap.set('n', '<Leader>lfo',
    inkscape_figures_open,
    {
      buffer = true,
      desc = 'Open a GUI window with current figures'
    }
  )
end

local function setup_keymaps()
  setup_wrap_keymaps()

  if latex_keymap.inkscape_figures then
    setup_inkscape_figures_keymaps()
  end
end

function latex_keymap.init(options)
  if type(options.inkscape_figures) == 'string' then
    latex_keymap.inkscape_figures = options.inkscape_figures
  end

  local augroup = api.nvim_create_augroup("LatexKeymap", {})

  api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.tex',
    callback = setup_keymaps,
    group = augroup,
  })
end

return latex_keymap
