local M = {}

function M.pack()
  local packer = require 'packer'
  packer.use {
    'Julian/lean.nvim',
  }
end

function M.setup()
  local lean = require 'lean'
  lean.setup {
    mappings = true,
  }
end

return M
