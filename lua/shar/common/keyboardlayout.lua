--[[
-- Keyboard layout preferences.
--]]
local vim = vim

vim.api.nvim_set_option_value('imsearch', 0, {})

--- vim-xkbswitch plugin

require('packer').use { 'lyokha/vim-xkbswitch' }

vim.g.XkbSwitchEnabled = 1
vim.g.XkbSwitchAssistNKeymap = 1 -- for command 'r' and 'f', 'F', 't', 'T'

--- CTRL-^ is 'iminsert' toggle key in Normal mode

vim.g.XkbSwitchIminsertToggleKey = '<C-^>'
