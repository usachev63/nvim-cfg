local M = {}

function M.pack()
  local packer = require 'packer'
  packer.use 'mfussenegger/nvim-jdtls'
end

function M.make_config()
  return {
    cmd = { 'jdtls' },
  }
end

function M.setup() end

return M
