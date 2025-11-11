local M = {}

local u_util = require 'u63.util'

local function set_literal_search_pattern(text, notify)
  local pattern = string.gsub('\\V' .. vim.fn.escape(text, '\\'), '\n', '\\n')
  vim.fn.setreg('/', pattern)
  if notify then
    vim.notify(
      'Search pattern set to match "' .. text .. '"',
      vim.log.levels.INFO,
      {}
    )
  end
end

function M.do_nullstar()
  local word_under_cursor = vim.fn.expand '<cword>'
  set_literal_search_pattern(word_under_cursor, true)
end

function M.do_visual_nullstar()
  local selection = u_util.get_visual_selection_text()
  set_literal_search_pattern(selection, false)
  vim.api.nvim_input('<Esc>')
end

function M.setup()
  vim.keymap.set({ 'n', 'x' }, '#', '<Nop>')
  vim.keymap.set('n', '*', M.do_nullstar)
  vim.keymap.set('x', '*', M.do_visual_nullstar)
end

return M
