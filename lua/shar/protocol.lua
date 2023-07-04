--- Configuration of various protocols:
--  LSPs, formatters, linters, DAPs, treesitter, etc.
-- @module protocol

local M = {}

local packer = require 'packer'
local treesitter = require 'shar.protocol.treesitter'
local lsp = require 'shar.protocol.lsp'
local formatter = require 'shar.protocol.formatter'

--- Initialize protocols module.
--
-- @param options
function M.init(options)
  packer.use 'williamboman/mason.nvim'
  local mason = require 'mason'
  mason.setup()
  if options.treesitter then
    treesitter.init()
  end
  if options.lsp then
    lsp.init()
  end
  if options.formatter then
    formatter.init()
  end
end

return M
