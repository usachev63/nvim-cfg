--- Common plugins declarations.
--
-- Plugins can also be declared in any other place with
--   require('packer').use 'username/reponame'.
local packer = require 'packer'

packer.use 'tpope/vim-surround'   -- surround text objects
packer.use 'tpope/vim-commentary' -- comments
packer.use 'tpope/vim-repeat'
packer.use 'nelstrom/vim-visual-star-search'
packer.use 'lambdalisue/suda.vim' -- sudo write fix
packer.use 'joshdick/onedark.vim' -- color theme
packer.use 'morhetz/gruvbox'      -- color theme
