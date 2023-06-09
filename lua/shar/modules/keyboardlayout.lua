--[[
-- Keyboard layout preferences.
--]]
local vim = vim
local api = vim.api
local g = vim.g

api.nvim_set_option_value('imsearch', 0, {})

--- vim-xkbswitch plugin

require('packer').use { 'lyokha/vim-xkbswitch' }

g.XkbSwitchEnabled = 1
g.XkbSwitchAssistNKeymap = 1 -- for command 'r' and 'f', 'F', 't', 'T'

--- CTRL-^ is 'iminsert' toggle key in Normal mode

g.XkbSwitchIminsertToggleKey = '<C-^>'
