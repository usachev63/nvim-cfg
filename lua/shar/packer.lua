--[[
-- Initialize packer.nvim plugin manager.
-- Declare common plugins.
--
-- Plugins can also be declared in any other place with
--   require('packer').use 'username/reponame',
-- but it must be done after this module is loaded.
]]
local packer = require 'packer'
packer.init()

packer.use 'wbthomason/packer.nvim' -- plugin manager itself

packer.use 'tpope/vim-surround'     -- surround text objects
packer.use 'tpope/vim-commentary'   -- comments
packer.use 'tpope/vim-repeat'
packer.use 'nelstrom/vim-visual-star-search'
packer.use 'lambdalisue/suda.vim' -- sudo write fix
packer.use 'joshdick/onedark.vim' -- color theme
packer.use 'morhetz/gruvbox'      -- color theme
