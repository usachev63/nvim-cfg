--[[
-- Entry point of my neovim configuration.
--]]

require 'shar.packer'

require 'shar.user.keymap'

vim.cmd 'source ~/.config/nvim/settings.vim' -- general settings

-- Change directory scripts
vim.cmd 'source ~/.config/nvim/chdir.vim'


-- Common plugins/utilities.
require 'shar.common.autopairs'
require 'shar.common.cmp'
require 'shar.common.fugitive'
require 'shar.common.keyboardlayout'
require 'shar.common.leap'
require 'shar.common.localcfg'
require 'shar.common.lualine'
require 'shar.common.tabby'
require 'shar.common.telescope'
require 'shar.common.terminal'
require 'shar.common.ultisnips'

-- Optional modules.
--
-- The list of loaded modules and their parameters
-- are configured in lua/shar/modules/config.lua.
require 'shar.modules.load'
