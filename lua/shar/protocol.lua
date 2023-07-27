---Configuration of various protocols:
---LSPs, formatters, linters, DAPs, treesitter, etc.

local M = {}

local options = require 'shar.options'
local treesitter = require 'shar.protocol.treesitter'
local lsp = require 'shar.protocol.lsp'
local formatter = require 'shar.protocol.formatter'
local linter = require 'shar.protocol.linter'

function M.pack()
  require('packer').use 'williamboman/mason.nvim'
  if options.protocol.treesitter then
    treesitter.pack()
  end
  if options.protocol.lsp then
    lsp.pack()
  end
  if options.protocol.formatter then
    formatter.pack()
  end
  if options.protocol.linter then
    linter.pack()
  end
end

---Initialize protocol module.
function M.init()
  local mason = require 'mason'
  mason.setup()
  if options.protocol.treesitter then
    treesitter.init()
  end
  if options.protocol.lsp then
    lsp.init()
  end
  if options.protocol.formatter then
    formatter.init()
  end
  if options.protocol.linter then
    linter.init()
  end
end

return M
