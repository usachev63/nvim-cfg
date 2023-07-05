--- toolkit-specific configurations.
-- @module toolkit

local M = {}

local options = require 'shar.options'

local tex = require 'shar.toolkit.tex'

function M.setup()
  local opts = options.toolkit
  if opts.tex.enabled then
    tex.init()
  end
end

return M
