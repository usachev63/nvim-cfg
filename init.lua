--[[
-- Entry point of my neovim configuration.
--]]

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
