--[[
-- UltiSnips: snippet engine
--]]
local vim = vim
local keymap = vim.keymap
local g = vim.g

local packer = require 'packer'
packer.use {
  'SirVer/ultisnips',
  ft = { 'tex', 'cpp', 'c' },
  requires = {
    'reconquest/vim-pythonx',
  }
}

keymap.set({ 'n', 'i' }, '<C-J>', '<Nop>')
g.UltiSnipsExpandTrigger = '<C-l>'
g.UltiSnipsJumpForwardTrigger = '<C-j>'
g.UltiSnipsJumpBackwardTrigger = '<C-k>'
