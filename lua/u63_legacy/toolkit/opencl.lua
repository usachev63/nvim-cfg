local M = {}

function M.pack()
  local packer = require 'packer'
  packer.use {
    'petRUShka/vim-opencl',
  }
end

function M.setup() end

return M
