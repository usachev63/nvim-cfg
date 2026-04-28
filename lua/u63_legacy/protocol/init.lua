---Configuration of various protocols:
---LSPs, formatters, linters, DAPs, treesitter, etc.

local M = {}

local options = require 'u63_legacy.options'
local treesitter = require 'u63_legacy.protocol.treesitter'
local lsp = require 'u63_legacy.protocol.lsp'
local formatter = require 'u63_legacy.protocol.formatter'
local linter = require 'u63_legacy.protocol.linter'
local u_dap = require 'u63_legacy.protocol.dap'

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
  if options.protocol.dap.enabled then
    u_dap.pack()
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
  if options.protocol.dap.enabled then
    u_dap.init()
  end
end

return M
