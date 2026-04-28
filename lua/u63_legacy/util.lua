local M = {}

---Move given position in current buffer one character to the right.
---
---Since we must support Unicode it does not necessarily mean
---"one byte to the right".
---
---Indexing is zero-based.
---
---@param line integer Line number.
---@param col integer Column number (byte offset).
---@return integer # New column number (byte offset; line remains the same).
local function increment_col(line, col)
  local text_after =
    unpack(vim.api.nvim_buf_get_text(0, line, col, line, col + 4, {}))
  local bytes_in_char = vim.str_byteindex(text_after, 1)
  return col + bytes_in_char
end

---Get the range of the current visual selection.
---
---Indexing in (0,0)-based. Row indices are end-inclusive,
---and column indices are end-exclusive.
---
---@return integer begin_line First line number of the selection.
---@return integer begin_col Starting column (byte offset) on first line.
---@return integer end_line Last line number of the selection.
---@return integer end_col Ending column (byte offset) on last line, exclusive.
---
---(begin_line, end_line) is strictly less than (end_line, end_col)
function M.get_visual_selection()
  local begin_line, begin_col = unpack(vim.fn.getpos 'v', 2)
  local end_line, end_col = unpack(vim.fn.getpos '.', 2)
  if
    begin_line > end_line or begin_line == end_line and begin_col > end_col
  then
    begin_line, end_line = end_line, begin_line
    begin_col, end_col = end_col, begin_col
  end
  begin_line, begin_col = begin_line - 1, begin_col - 1
  end_line, end_col = end_line - 1, end_col - 1
  end_col = increment_col(end_line, end_col)
  return begin_line, begin_col, end_line, end_col
end

---Get the contents of the current visual selection.
---
---@return string # The contents of the current visual selection.
function M.get_visual_selection_text()
  local begin_line, begin_col, end_line, end_col = M.get_visual_selection()
  local lines =
    vim.api.nvim_buf_get_text(0, begin_line, begin_col, end_line, end_col, {})
  return table.concat(lines, '\n')
end

return M
