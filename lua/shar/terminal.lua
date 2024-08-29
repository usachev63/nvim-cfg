---Shell and terminal buffer settings.

local M = {}

local vim = vim
local api = vim.api
local fn = vim.fn
local o = vim.o
local keymap = vim.keymap

---Related autocommand group.
local augroup

---Set appropriate 'shell' option.
local function set_shell()
  if fn.executable 'zsh' then
    o.shell = '/usr/bin/zsh -li'
  elseif fn.executable 'bash' then
    o.shell = '/usr/bin/bash -li'
  end
end

---Escape from terminal buffer with <Esc> key.
local function fix_escape()
  keymap.set('t', '<Esc>', '<C-\\><C-n>')
  keymap.set('t', '<C-[>', '<C-\\><C-n>')
end

---Autocommand setting local options in terminal buffer.
local function set_options()
  api.nvim_create_autocmd('TermOpen', {
    pattern = '*',
    callback = function()
      api.nvim_set_option_value('number', false, { scope = 'local', win = 0 })
      api.nvim_set_option_value('spell', false, { scope = 'local', win = 0 })
    end,
    group = augroup,
  })
end

function M.setup()
  set_shell()
  fix_escape()
  augroup = api.nvim_create_augroup('Terminal', {})
  set_options()
end

return M
