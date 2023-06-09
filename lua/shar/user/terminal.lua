--[[
-- Shell and terminal buffer settings.
--]]
local vim = vim
local api = vim.api
local fn = vim.fn
local o = vim.o
local keymap = vim.keymap

-- Set appropriate 'shell' option
if fn.executable('zsh') then
  o.shell = '/usr/bin/zsh -li'
elseif fn.executable('bash') then
  o.shell = '/usr/bin/bash -li'
end

-- Escape from terminal buffer with Esc.
keymap.set('t', '<Esc>', '<C-\\><C-n>')
keymap.set('t', '<C-[>', '<C-\\><C-n>')

-- Autocommands
local augroup = api.nvim_create_augroup('Terminal', {})
api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  callback = function()
    api.nvim_set_option_value('number', false, { scope = 'local', win = 0 })
  end,
  group = augroup,
})
