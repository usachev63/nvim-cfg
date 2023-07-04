--- Formatters support.
-- @module protocol.formatter

local M = {}

local packer = require 'packer'

function M.init()
  packer.use 'mhartington/formatter.nvim'
  -- formatter.nvim
  local formatter = require 'formatter'
  -- TODO split formatters into separate files
  formatter.setup {
    filetype = {
      json = {
        require('formatter.filetypes.json').fixjson,
      }
    }
  }
end

return M
