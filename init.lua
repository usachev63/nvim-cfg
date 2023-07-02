--[[
-- Entry point of my neovim configuration.
--]]

-- Hijack netrw for nvim-tree
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

require 'shar.packer'

require 'shar.user.appearance'
require 'shar.user.keymap'
require 'shar.user.indent'
require 'shar.user.terminal'
require 'shar.user.netrw'
require 'shar.user.settings'

-- Optional modules.
--
-- The list of loaded modules and their parameters
-- are configured in lua/shar/modules/config.lua.
require 'shar.modules.load'
