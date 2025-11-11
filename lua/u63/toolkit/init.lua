---toolkit-specific configurations.

local M = {}

local options = require 'u63.options'

local function get_kits()
  local kits = {}
  for kit_name, kit_options in pairs(options.toolkit) do
    if
      type(kit_name) == 'string'
      and type(kit_options) == 'table'
      and kit_options.enabled
    then
      local module = require('u63.toolkit.' .. kit_name)
      table.insert(kits, module)
    end
  end
  return kits
end

function M.pack()
  for _, kit in ipairs(get_kits()) do
    kit.pack()
  end
end

function M.setup()
  for _, kit in ipairs(get_kits()) do
    kit.setup()
  end
end

return M
