--[[
-- nvim-config-local: support for local .vimrc files in Neovim.
--]]
local packer = require 'packer'
packer.use 'klen/nvim-config-local'

require('config-local').setup {
  -- Default configuration (optional)
  config_files = { ".vimrc.lua", ".vimrc" },            -- Config file patterns to load (lua supported)
  hashfile = vim.fn.stdpath("data") .. "/config-local", -- Where the plugin keeps files data
  autocommands_create = true,                           -- Create autocommands (VimEnter, DirectoryChanged)
  commands_create = true,                               -- Create commands (ConfigSource, ConfigEdit, ConfigTrust, ConfigIgnore)
  silent = false,                                       -- Disable plugin messages (Config loaded/ignored)
  lookup_parents = false,                               -- Lookup config files in parent directories
}
