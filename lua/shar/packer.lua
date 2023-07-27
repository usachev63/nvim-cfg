local M = {}

local packer = require 'packer'

---Initialize packer.nvim plugin manager.
local function init_packer()
  packer.init()
  packer.use 'wbthomason/packer.nvim' -- declare plugin manager itself
end

---Declare common plugins.
local function pack_common()
  packer.use 'tpope/vim-surround' -- surround text objects
  packer.use 'tpope/vim-commentary' -- comments
  packer.use 'tpope/vim-repeat'
  packer.use 'nelstrom/vim-visual-star-search'
  packer.use 'lambdalisue/suda.vim' -- sudo write fix
end

---Declare plugins from other modules
local function pack_modules()
  local modules = {
    'editing',
    'key',
    'motion',
    'navigation',
    'protocol',
    'toolkit',
    'ui',
  }
  for _, module in pairs(modules) do
    require('shar.' .. module).pack()
  end
end

---Declare all required plugins using packer.nvim.
function M.pack()
  init_packer()
  pack_common()
  if require('shar.options').localvimrc then
    packer.use 'klen/nvim-config-local'
  end
  pack_modules()
end

return M
