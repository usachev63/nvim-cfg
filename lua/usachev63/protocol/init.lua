---Configuration of various protocols:
---LSPs, formatters, linters, DAPs, treesitter, etc.

local M = {}

local options = require 'usachev63.options'
local treesitter = require 'usachev63.protocol.treesitter'
local lsp = require 'usachev63.protocol.lsp'
local formatter = require 'usachev63.protocol.formatter'
local linter = require 'usachev63.protocol.linter'

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
