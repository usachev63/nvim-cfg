--[[
-- nvim-tree: a file explorer tree
--]]
require('packer').use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
}

local nvim_tree = require 'nvim-tree'
nvim_tree.setup {
  disable_netrw = true,
  hijack_directories = {
    enable = false,
  },
}

-- Open netrw at the directory of the file.
-- Instead of :E (now getting E464 error)
vim.keymap.set('n', '<Leader>e', nvim_tree.open_replacing_current_buffer)

