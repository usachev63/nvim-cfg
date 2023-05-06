--[[
-- UltiSnips: snippet engine
--]]
local vim = vim
local packer = require 'packer'
packer.use {
  'SirVer/ultisnips',
  ft = { 'tex', 'cpp', 'c' },
  requires = {
    'reconquest/vim-pythonx',
  }
}

vim.api.nvim_set_keymap('n', '<C-j>', '<Nop>', { noremap = true })
vim.api.nvim_set_keymap('i', '<C-j>', '<Nop>', { noremap = true })
vim.g.UltiSnipsExpandTrigger = '<C-l>'
vim.g.UltiSnipsJumpForwardTrigger = '<C-j>'
vim.g.UltiSnipsJumpBackwardTrigger = '<C-k>'
