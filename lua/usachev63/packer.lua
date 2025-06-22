local M = {}

local packer = require 'packer'

---Declare plugins from other modules
local function pack_modules()
  local modules = {
    'common',
    'editing',
    'key',
    'motion',
    'navigation',
    'protocol',
    'toolkit',
    'ui',
    'terminal',
  }
  for _, module in pairs(modules) do
    require('usachev63.' .. module).pack()
  end
end

---Declare all required plugins using packer.nvim.
function M.pack()
  packer.init()
  packer.use 'wbthomason/packer.nvim' -- declare plugin manager itself
  pack_modules()
end

return M
