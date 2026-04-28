local u_visual_selection = require("u63.lib.visual_selection")

local augroup = vim.api.nvim_create_augroup('u63/tex', {})

local function init_globals()
  vim.g.vimtex_view_method = "zathura"
  vim.g.vimtex_compiler_method = "latexmk"
  vim.g.vimtex_compiler_latexmk = {
    build_dir = "",
    callback = true,
    continuous = true,
    executable = "latexmk",
    hooks = {},
    options = {
      "-verbose",
      "-file-line-error",
      "-synctex=1",
      "-interaction=nonstopmode",
      "-shell-escape"
    },
  }
  vim.g.vimtex_subfile_start_local = true
  vim.g.vimtex_quickfix_mode = false
  vim.g.vimtex_indent_on_ampersands = false
  vim.g.tex_conceal = "abdgm"
  vim.g.vimtex_env_toggle_math_map = {
    ["$"] = "align*",
    ["align*"] = "$",
    ["align"] = "$",
    ["$$"] = "align*",
    ["\\["] = "align*",
  }
  vim.g.vimtex_mappings_enabled = false
end

---Local extmark namespace.
local namespace = vim.api.nvim_create_namespace 'LatexKeymap'

---Wrap the current visual selection with given text.
---
---@param prefix string Text to insert before.
---@param suffix string Text to insert after.
---@return integer end_line Line number of the end of wrapped selection
---(including wrapping text).
---@return integer end_col Column number of the end of wrapped selection.
local function wrap(prefix, suffix)
  local begin_line, begin_col, end_line, end_col = u_visual_selection.get_visual_selection()
  local end_mark = vim.api.nvim_buf_set_extmark(0, namespace, end_line, end_col, {})
  vim.api.nvim_buf_set_text(0, end_line, end_col, end_line, end_col, { suffix })
  vim.api.nvim_buf_set_text(
    0,
    begin_line,
    begin_col,
    begin_line,
    begin_col,
    { prefix }
  )
  end_line, end_col = unpack(vim.api.nvim_buf_get_extmark_by_id(0, namespace, end_mark, {}))
  vim.api.nvim_buf_del_extmark(0, namespace, end_mark)
  vim.api.nvim_win_set_cursor(0, { end_line + 1, end_col })
  vim.api.nvim_input '<Esc>'
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
  vim.api.nvim_win_set_cursor(0, { line + 1, col - 1 })
  vim.cmd 'startinsert'
end

---Wrap the current visual selection with a \left..\right delimiter.
---
---@param open string The opening delimiter (excluding \left).
---@param close string The closing delimiter (excluding \right).
local function wrap_delimiter(open, close)
  wrap(string.format('\\left%s ', open), string.format(' \\right%s', close))
end

---Set up keymaps for wrapping a selection with a command.
local function setup_wrap_keymaps()
  vim.keymap.set('x', '<Leader>bf', function()
    wrap_command 'textbf'
  end, {
    buffer = true,
    desc = 'Wrap a \\textbf command around a visual selection',
  })
  vim.keymap.set('x', '<Leader>em', function()
    wrap_command 'emph'
  end, {
    buffer = true,
    desc = 'Wrap a \\emph command around a visual selection',
  })
  vim.keymap.set('x', '<Leader>u', wrap_underbrace, {
    buffer = true,
    desc = 'Wrap an \\underbrace around a visual selection',
  })
  vim.keymap.set('x', '<Leader>sb', function()
    wrap_delimiter('(', ')')
  end, {
    buffer = true,
    desc = 'Wrap a \\left( .. \\right) delimiter around a visual selection',
  })
  vim.keymap.set('x', '<Leader>sB', function()
    wrap_delimiter('\\{', '\\}')
  end, {
    buffer = true,
    desc = 'Wrap a \\left\\{ .. \\right\\} delimiter around a visual selection',
  })
  vim.keymap.set('x', '<Leader>sa', function()
    wrap_delimiter('|', '|')
  end, {
    buffer = true,
    desc = 'Wrap a \\left| .. \\right| delimiter around a visual selection',
  })
  vim.keymap.set('x', '<Leader>sq', function()
    wrap_delimiter('[', ']')
  end, {
    buffer = true,
    desc = 'Wrap a \\left[ .. \\right] delimiter around a visual selection',
  })
  vim.keymap.set('x', '<Leader>sn', function()
    wrap_delimiter('\\|', '\\|')
  end, {
    buffer = true,
    desc = 'Wrap a \\left\\| .. \\right\\| delimiter around a visual selection',
  })
  vim.keymap.set('x', '<Leader>sQ', function()
    wrap('<<', '>>')
  end, {
    buffer = true,
    desc = 'Wrap a quote << .. >> around a visual selection',
  })
end

---Set up vimtex keymaps in current buffer.
local function setup_vimtex_keymaps()
  local function set(mode, lhs, rhs)
    vim.keymap.set(mode, lhs, rhs, { buffer = true })
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

  if vim.g.vimtex_compiler_enabled then
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

  if vim.g.vimtex_motion_enabled then
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

  if vim.g.vimtex_text_obj_enabled then
    set({ 'x', 'o' }, 'id', '<Plug>(vimtex-id)')
    set({ 'x', 'o' }, 'ad', '<Plug>(vimtex-ad)')
    set({ 'x', 'o' }, 'i$', '<Plug>(vimtex-i$)')
    set({ 'x', 'o' }, 'a$', '<Plug>(vimtex-a$)')
    set({ 'x', 'o' }, 'iP', '<Plug>(vimtex-iP)')
    set({ 'x', 'o' }, 'aP', '<Plug>(vimtex-aP)')
    set({ 'x', 'o' }, 'im', '<Plug>(vimtex-im)')
    set({ 'x', 'o' }, 'am', '<Plug>(vimtex-am)')

    -- we assume vimtex#text_obj#targets#enabled() is false

    vim.g.vimtex_text_obj_variant = 'vimtex'

    set({ 'x', 'o' }, 'ie', '<Plug>(vimtex-ie)')
    set({ 'x', 'o' }, 'ae', '<Plug>(vimtex-ae)')
    set({ 'x', 'o' }, 'ic', '<Plug>(vimtex-ic)')
    set({ 'x', 'o' }, 'ac', '<Plug>(vimtex-ac)')
  end

  if vim.g.vimtex_toc_enabled then
    set('n', '<Leader>lt', '<Plug>(vimtex-toc-open)')
    set('n', '<Leader>lT', '<Plug>(vimtex-toc-toggle)')
  end

  if vim.b.vimtex and vim.b.vimtex.viewer then
    set('n', '<Leader>lv', '<Plug>(vimtex-view)')
    if not vim.fn.empty(vim.fn.maparg('<Plug>(vimtex-reverse-search)', 'n')) then
      set('n', '<Leader>lr', '<Plug>(vimtex-reverse-search)')
    end
  end

  if vim.g.vimtex_imaps_enabled then
    set('n', '<Leader>lm', '<Plug>(vimtex-imaps-list)')
  end

  if vim.g.vimtex_doc_enabled then
    set('n', '<Leader>lK', '<Plug>(vimtex-doc-package)')
  end
end

local function on_open_file()
  vim.api.nvim_win_set_option(0, 'conceallevel', 0)

  -- autowrite
  vim.api.nvim_create_autocmd({ 'TextChanged', 'InsertLeave' }, {
    buffer = 0,
    command = 'silent update',
    group = augroup,
  })

  setup_wrap_keymaps()
  setup_vimtex_keymaps()
end

return {
  "lervag/vimtex",
  config = function()
    init_globals()

    vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
      pattern = '*.tex',
      callback = function()
        on_open_file()
      end,
      group = augroup,
    })
  end
}
