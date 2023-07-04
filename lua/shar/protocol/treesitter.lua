--- treesitter support.
-- @module protocol.treesitter

local M = {}

local packer = require 'packer'

function M.init()
  packer.use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_install = require 'nvim-treesitter.install'
      local ts_update = ts_install.update {
        with_sync = true,
      }
      ts_update()
    end,
  }
end

return M
