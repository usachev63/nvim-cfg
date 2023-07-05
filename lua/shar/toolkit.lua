--- toolkit-specific configurations.
-- @module toolkit

local M = {}

local options = require 'shar.options'

function M.setup()
  for kit_name, kit_options in pairs(options.toolkit) do
    if type(kit_name) == 'string' and type(kit_options) == 'table' and
        kit_options.enabled then
      local module = require('shar.toolkit.' .. kit_name)
      module.setup()
    end
  end
end

return M
