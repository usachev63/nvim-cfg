local M = {}

function M.do_nullstar()
  local word_under_cursor = vim.fn.expand '<cword>'
  vim.fn.setreg('/', word_under_cursor)
  vim.notify(
    'Search pattern set to "' .. word_under_cursor .. '"',
    vim.log.levels.INFO,
    {}
  )
end

function M.setup()
  vim.keymap.set('n', '#', '<Nop>')
  vim.keymap.set('n', '*', M.do_nullstar)
end

return M
