---Shell and terminal buffer settings.

local M = {}

local vim = vim
local api = vim.api
local fn = vim.fn
local o = vim.o
local keymap = vim.keymap

---Related autocommand group.
local augroup

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

function M.pack()
  local packer = require 'packer'
  packer.use {
    'akinsho/toggleterm.nvim',
    tag = '*',
  }
end

function M.setup()
  --Escape from terminal buffer with <Esc> key.
  keymap.set('t', '<Esc>', '<C-\\><C-n>')
  keymap.set('t', '<C-[>', '<C-\\><C-n>')
  augroup = api.nvim_create_augroup('Terminal', {})
  set_options()
  require('toggleterm').setup {
    open_mapping = [[<C-\>]],
    direction = 'horizontal',
  }
end

return M
