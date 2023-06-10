--[[
-- Entry point of my neovim configuration.
--]]

require 'shar.packer'

require 'shar.user.appearance'
require 'shar.user.keymap'
require 'shar.user.indent'
require 'shar.user.terminal'
require 'shar.user.netrw'

vim.cmd 'source ~/.config/nvim/settings.vim' -- general settings

-- Change directory scripts
vim.cmd 'source ~/.config/nvim/chdir.vim'

-- Optional modules.
--
-- The list of loaded modules and their parameters
-- are configured in lua/shar/modules/config.lua.
require 'shar.modules.load'
