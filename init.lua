--[[
-- Entry point of my neovim configuration.
--]]
require 'shar.packer'
vim.cmd 'source ~/.config/nvim/settings.vim' -- general settings
vim.cmd 'source ~/.config/nvim/maps.vim'     -- general maps

-- Change directory scripts
vim.cmd 'source ~/.config/nvim/chdir.vim'

-- Common plugins/utilities.
require 'shar.common.autopairs'
require 'shar.common.coq_nvim'
require 'shar.common.fugitive'
require 'shar.common.leap'
require 'shar.common.localcfg'
require 'shar.common.lualine'
require 'shar.common.tabby'
require 'shar.common.telescope'
require 'shar.common.terminal'
require 'shar.common.ultisnips'

-- Configuration of LSP, linters, formatters, etc.
require 'shar.lsp.main'

-- Optional modules.
--
-- The list of loaded modules and their parameters
-- are configured in lua/shar/modules/config.lua.
require 'shar.modules.load'
