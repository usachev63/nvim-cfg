--[[
-- Keyboard layout preferences.
--]]
local vim = vim

vim.api.nvim_set_option_value('imsearch', false, {})

--- vim-xkbswitch plugin

require('packer').use { 'lyokha/vim-xkbswitch' }

vim.g.XkbSwitchEnabled = 1
vim.g.XkbSwitchAssistNKeymap = 1 -- for command 'r' and 'f', 'F', 't', 'T'

--- CTRL-^ is 'iminsert' toggle key in Normal mode

vim.g.XkbSwitchIminsertToggleKey = '<C-^>'

local lualine = require 'lualine'

function Shar_KeyboardLayout_toggle_iminsert()
  local iminsert_value = vim.api.nvim_buf_get_option(0, 'iminsert')
  if iminsert_value == 0 then
    iminsert_value = 1
  else
    iminsert_value = 0
  end
  vim.api.nvim_buf_set_option(0, 'iminsert', iminsert_value)
  lualine.refresh()
end

--vim.api.nvim_set_keymap('n', '<C-^>',
--  '<cmd>lua Shar_KeyboardLayout_toggle_iminsert()<cr>', { noremap = true })
