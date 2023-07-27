---nvim-cmp: autocompletion engine

local M = {}

local options = require 'shar.options'

---Compile a list of source for nvim-cmp from shar-nvim-cfg options.
---
---@return table[] # The list of sources for nvim-cmp.
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

function M.pack()
  require('packer').use {
    'hrsh7th/nvim-cmp',
    requires = {
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-nvim-lsp',
    },
  }
end

---Set up integration with nvim-cmp.
function M.init()
  local cmp = require 'cmp'
  cmp.setup {
    mapping = cmp.mapping.preset.insert {},
    sources = cmp.config.sources(get_sources()),
  }
end

return M
