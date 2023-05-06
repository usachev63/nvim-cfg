--[[
-- telescope.nvim: fuzzy finder over lists (mainly files).
--]]
local vim = vim
local packer = require 'packer'
packer.use {
  'nvim-telescope/telescope.nvim',
  branch = '0.1.x',
  requires = {
    'nvim-lua/plenary.nvim',
    'nvim-telescope/telescope-fzy-native.nvim',
  },
}

local telescope = require 'telescope'

local builtin = require 'telescope.builtin'
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
telescope.load_extension('fzy_native')
