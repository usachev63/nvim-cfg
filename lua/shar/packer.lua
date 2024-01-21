local M = {}

local packer = require 'packer'
local options = require 'shar.options'

---Declare common plugins.
local function pack_common()
  packer.use 'tpope/vim-surround' -- surround text objects
  packer.use 'tpope/vim-commentary' -- comments
  packer.use 'tpope/vim-repeat'
  packer.use 'lambdalisue/suda.vim' -- sudo write fix
  if options.localvimrc then
    packer.use 'klen/nvim-config-local'
  end
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
  packer.init()
  packer.use 'wbthomason/packer.nvim' -- declare plugin manager itself
  pack_common()
  pack_modules()
end

return M
