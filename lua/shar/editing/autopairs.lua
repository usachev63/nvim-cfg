---nvim-autopairs: bracket autocompletion engine.

local M = {}

local vim = vim
local keymap = vim.keymap

local npairs

---Callback invoked upon pressing Enter (<CR>).
local function on_enter()
  if vim.fn.pumvisible() ~= 0 then
    if vim.fn.complete_info({ 'selected' }).selected ~= -1 then
      return npairs.esc '<C-y>'
    else
      return npairs.esc '<C-e>' .. npairs.autopairs_cr()
    end
  else
    return npairs.autopairs_cr()
  end
end

---Callback invoked upon pressing Backspace (<BS>).
local function on_backspace()
  if
    vim.fn.pumvisible() ~= 0
    and vim.fn.complete_info({ 'mode' }).mode == 'eval'
  then
    return npairs.esc '<C-e>' .. npairs.autopairs_bs()
  else
    return npairs.autopairs_bs()
  end
end

function M.pack()
  require('packer').use 'windwp/nvim-autopairs'
end

---Set up integration with nvim-autopairs.
function M.init()
  npairs = require 'nvim-autopairs'
  npairs.setup {
    map_bs = false,
    map_cr = true,
  }
  keymap.set('i', '<CR>', on_enter, { expr = true, replace_keycodes = false })
  keymap.set(
    'i',
    '<BS>',
    on_backspace,
    { expr = true, replace_keycodes = false }
  )
end

return M
