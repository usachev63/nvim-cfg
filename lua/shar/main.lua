--- The main module of my Neovim config

local M = {}

local vim = vim
local g = vim.g
local packer = require 'packer'

---Initialize my Neovim config.
function M.init()
  -- Hijack netrw loading for nvim-tree plugin
  g.loaded_netrw = 1
  g.loaded_netrwPlugin = 1

  -- Initialize packer.nvim plugin manager
  packer.init()
  packer.use 'wbthomason/packer.nvim' -- plugin manager itself

  require('shar.langmapper').init()

  require 'shar.common_plugins'

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
end

return M
