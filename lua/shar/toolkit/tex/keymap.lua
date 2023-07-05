---Handy keymaps for editing TeX documents.

local M = {}

local vim = vim
local api = vim.api
local keymap = vim.keymap
local fn = vim.fn
local ui = vim.ui
local b = vim.b
local g = vim.g

local options = require 'shar.options'

---Local extmark namespace.
local namespace = api.nvim_create_namespace('LatexKeymap')

---Move given cursor one character to the right.
---
---Since we must support Unicode it does not necessarily mean
---"one byte to the right".
---
---@param line integer Line number.
---@param col integer Column number.
---@return integer # New column number (line remains the same).
local function increment_col(line, col)
  local text_after = unpack(api.nvim_buf_get_text(0, line, col, line, col + 4, {}))
  local bytes_in_char = vim.str_byteindex(text_after, 1)
  return col + bytes_in_char
end

---Get the (0,0)-based (row, column)-like, end-exclusive range
---of the current visual selection.
---
---@return integer begin_line Line number of the beginning.
---@return integer begin_col Column number of the beginning.
---@return integer end_line Line number of the end.
---@return integer end_col Column number of the end.
---
---The returned beginning coordinates are less than the end coordinates.
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

---Wrap the current visual selection with given text.
---
---@param prefix string Text to insert before.
---@param suffix string Text to insert after.
---@return integer end_line Line number of the end of wrapped selection
---(including wrapping text).
---@return integer end_col Column number of the end of wrapped selection.
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

---Wrap the current visual selection with a TeX command.
---
---@param command string Name of the TeX command.
local function wrap_command(command)
  wrap(string.format('\\%s{', command), '}')
end

---Wrap the current visual selection with \underbrace command,
---insert a lower index after the command, and place the
---user in insert mode into this index.
local function wrap_underbrace()
  local line, col = wrap('\\underbrace{', '}_{}')
  api.nvim_win_set_cursor(0, { line + 1, col - 1 })
  vim.cmd 'startinsert'
end

---Wrap the current visual selection with a \left..\right delimiter.
---
---@param open string The opening delimiter (excluding \left).
---@param close string The closing delimiter (excluding \right).
local function wrap_delimiter(open, close)
  wrap(
    string.format('\\left%s ', open),
    string.format(' \\right%s', close)
  )
end

---Set up keymaps for wrapping a selection with a command.
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

local inkscape_figures_tool_path

---Get figures directory of the current TeX project.
---
---@return string
local function get_figures_dir()
  return b.vimtex.root .. '/figures/'
end

---Ensure that an inkscape-figures watchdog is active.
local function inkscape_figures_watch()
  vim.system {
    inkscape_figures_tool_path,
    'watch',
  }
end

---Get rid of characters in the figure name
---that inkscape-figures does not support.
---
---@param figure_name string
---@return string
---@return ...
local function prune_figure_name(figure_name)
  return figure_name:lower():gsub(' ', '_')
end

---Ask user for a name of the new figure.
---
---@return string? figure_name Name of the new figure or nil
---(if user changed their mind).
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

---Paste a code snippet into the buffer which includes the specified figure.
---
---@param figure_name string
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

---Create a new figure with inkscape-figures.
local function inkscape_figures_create()
  inkscape_figures_watch()
  local figure_name = ask_new_figure_name()
  if not figure_name then
    return
  end
  print('New Figure:', figure_name)
  paste_include_figure_snippet(figure_name)
  vim.system {
    inkscape_figures_tool_path,
    'create',
    figure_name,
    get_figures_dir(),
  }
end

---Open inkscape-figures GUI menu.
local function inkscape_figures_open()
  inkscape_figures_watch()
  vim.system {
    inkscape_figures_tool_path,
    'edit',
    get_figures_dir(),
  }
end

---Set up keymaps for integration with inkscape-figures tool.
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

---Set up vimtex keymaps in current buffer.
local function setup_vimtex_keymaps()
  local function set(mode, lhs, rhs)
    keymap.set(mode, lhs, rhs, { buffer = true })
  end

  set('n', '<Leader>li', '<Plug>(vimtex-info)')
  set('n', '<Leader>lI', '<Plug>(vimtex-info-full)')
  set('n', '<Leader>lx', '<Plug>(vimtex-reload)')
  set('n', '<Leader>lX', '<Plug>(vimtex-reload-state)')
  set('n', '<Leader>ls', '<Plug>(vimtex-toggle-main)')
  set('n', '<Leader>lq', '<Plug>(vimtex-log)')
  set('n', '<Leader>la', '<Plug>(vimtex-context-menu)')

  set('n', 'ds$', '<Plug>(vimtex-env-delete-math)')
  set('n', 'cs$', '<Plug>(vimtex-env-change-math)')
  set('n', 'dse', '<Plug>(vimtex-env-delete)')
  set('n', 'cse', '<Plug>(vimtex-env-change)')
  set('n', 'tse', '<Plug>(vimtex-env-toggle-star)')
  set('n', 'ts$', '<Plug>(vimtex-env-toggle-math)')
  set('n', '<F6>', '<Plug>(vimtex-env-surround-line)')
  set('x', '<F6>', '<Plug>(vimtex-env-surround-visual)')

  set('n', 'dsc', '<Plug>(vimtex-cmd-delete)')
  set('n', 'csc', '<Plug>(vimtex-cmd-change)')
  set('n', 'tsc', '<Plug>(vimtex-cmd-toggle-star)')
  set({ 'n', 'x' }, 'tsf', '<Plug>(vimtex-cmd-toggle-frac)')
  set({ 'i', 'n', 'x' }, '<F7>', '<Plug>(vimtex-cmd-create)')

  set('n', 'dsd', '<Plug>(vimtex-delim-delete)')
  set('n', 'csd', '<Plug>(vimtex-delim-change-math)')
  set({ 'n', 'x' }, 'tsd', '<Plug>(vimtex-delim-toggle-modifier)')
  set({ 'n', 'x' }, 'tsD', '<Plug>(vimtex-delim-toggle-modifier-reverse)')
  set('i', ']]', '<Plug>(vimtex-delim-close)')
  set('n', '<F8>', '<Plug>(vimtex-delim-add-modifiers)')

  if g.vimtex_compiler_enabled then
    set('n', '<Leader>ll', '<Plug>(vimtex-compile)')
    set('n', '<Leader>lo', '<Plug>(vimtex-compile-output)')
    set({ 'n', 'x' }, '<Leader>lL', '<Plug>(vimtex-compile-selected)')
    set('n', '<Leader>lk', '<Plug>(vimtex-stop)')
    set('n', '<Leader>lK', '<Plug>(vimtex-stop-all)')
    set('n', '<Leader>le', '<Plug>(vimtex-errors)')
    set('n', '<Leader>lc', '<Plug>(vimtex-clean)')
    set('n', '<Leader>lC', '<Plug>(vimtex-clean-full)')
    set('n', '<Leader>lg', '<Plug>(vimtex-status)')
    set('n', '<Leader>lG', '<Plug>(vimtex-status-all)')
  end

  if g.vimtex_motion_enabled then
    set({ 'n', 'x', 'o' }, '%', '<Plug>(vimtex-%)')

    set({ 'n', 'x', 'o' }, ']]', '<Plug>(vimtex-]])')
    set({ 'n', 'x', 'o' }, '][', '<Plug>(vimtex-][)')
    set({ 'n', 'x', 'o' }, '[]', '<Plug>(vimtex-[])')
    set({ 'n', 'x', 'o' }, '[[', '<Plug>(vimtex-[[)')

    set({ 'n', 'x', 'o' }, ']M', '<Plug>(vimtex-]M)')
    set({ 'n', 'x', 'o' }, ']m', '<Plug>(vimtex-]m)')
    set({ 'n', 'x', 'o' }, '[M', '<Plug>(vimtex-[M)')
    set({ 'n', 'x', 'o' }, '[m', '<Plug>(vimtex-[m)')

    set({ 'n', 'x', 'o' }, ']N', '<Plug>(vimtex-]N)')
    set({ 'n', 'x', 'o' }, ']n', '<Plug>(vimtex-]n)')
    set({ 'n', 'x', 'o' }, '[N', '<Plug>(vimtex-[N)')
    set({ 'n', 'x', 'o' }, '[n', '<Plug>(vimtex-[n)')

    set({ 'n', 'x', 'o' }, ']R', '<Plug>(vimtex-]R)')
    set({ 'n', 'x', 'o' }, ']r', '<Plug>(vimtex-]r)')
    set({ 'n', 'x', 'o' }, '[R', '<Plug>(vimtex-[R)')
    set({ 'n', 'x', 'o' }, '[r', '<Plug>(vimtex-[r)')

    set({ 'n', 'x', 'o' }, ']/', '<Plug>(vimtex-]/)')
    set({ 'n', 'x', 'o' }, ']*', '<Plug>(vimtex-]*)')
    set({ 'n', 'x', 'o' }, '[/', '<Plug>(vimtex-[/)')
    set({ 'n', 'x', 'o' }, '[*', '<Plug>(vimtex-[*)')
  end

  if g.vimtex_text_obj_enabled then
    set({ 'x', 'o' }, 'id', '<Plug>(vimtex-id)')
    set({ 'x', 'o' }, 'ad', '<Plug>(vimtex-ad)')
    set({ 'x', 'o' }, 'i$', '<Plug>(vimtex-i$)')
    set({ 'x', 'o' }, 'a$', '<Plug>(vimtex-a$)')
    set({ 'x', 'o' }, 'iP', '<Plug>(vimtex-iP)')
    set({ 'x', 'o' }, 'aP', '<Plug>(vimtex-aP)')
    set({ 'x', 'o' }, 'im', '<Plug>(vimtex-im)')
    set({ 'x', 'o' }, 'am', '<Plug>(vimtex-am)')

    -- we assume vimtex#text_obj#targets#enabled() is false

    g.vimtex_text_obj_variant = 'vimtex'

    set({ 'x', 'o' }, 'ie', '<Plug>(vimtex-ie)')
    set({ 'x', 'o' }, 'ae', '<Plug>(vimtex-ae)')
    set({ 'x', 'o' }, 'ic', '<Plug>(vimtex-ic)')
    set({ 'x', 'o' }, 'ac', '<Plug>(vimtex-ac)')
  end

  if g.vimtex_toc_enabled then
    set('n', '<Leader>lt', '<Plug>(vimtex-toc-open)')
    set('n', '<Leader>lT', '<Plug>(vimtex-toc-toggle)')
  end

  if b.vimtex and b.vimtex.viewer then
    set('n', '<Leader>lv', '<Plug>(vimtex-view)')
    if not fn.empty(fn.maparg('<Plug>(vimtex-reverse-search)', 'n')) then
      set('n', '<Leader>lr', '<Plug>(vimtex-reverse-search)')
    end
  end

  if g.vimtex_imaps_enabled then
    set('n', '<Leader>lm', '<Plug>(vimtex-imaps-list)')
  end

  if g.vimtex_doc_enabled then
    set('n', '<Leader>lK', '<Plug>(vimtex-doc-package)')
  end
end

---Set up TeX-related keymaps in current buffer.
local function setup_keymaps()
  setup_wrap_keymaps()

  if inkscape_figures_tool_path then
    setup_inkscape_figures_keymaps()
  end

  setup_vimtex_keymaps()
end

---Initialize TeX-related keymaps setup.
function M.init()
  local opts = options.toolkit.tex
  if type(opts.inkscape_figures) == 'string' then
    inkscape_figures_tool_path = opts.inkscape_figures
  end

  local augroup = api.nvim_create_augroup("LatexKeymap", {})

  api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = '*.tex',
    callback = setup_keymaps,
    group = augroup,
  })
end

return M
