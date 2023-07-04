--- nvim-cmp: autocompletion engine
-- @module editing.cmp

local M = {}

local packer = require 'packer'
local options = require 'shar.options'

local function get_sources()
  local sources = {}
  if type(options.protocol.lsp) == 'table' then
    table.insert(sources, {
      name = 'nvim_lsp',
    })
  end
  table.insert(sources, {
    name = 'buffer',
    option = {
      keyword_pattern = [[\k\+]],
    },
  })
  return sources
end

function M.init()
  packer.use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
    },
  }
  local cmp = require 'cmp'
  cmp.setup {
    mapping = cmp.mapping.preset.insert {},
    sources = cmp.config.sources(get_sources())
  }
end

return M
