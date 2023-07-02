--[[
-- nvim-cmp: autocompletion engine.
--]]
require('packer').use {
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-nvim-lsp',
  },
}

local cmp = require 'cmp'
cmp.setup {
  mapping = cmp.mapping.preset.insert {},
  sources = cmp.config.sources {
    {
      name = 'nvim_lsp',
    },
    {
      name = 'buffer',
      option = {
        keyword_pattern = [[\k\+]],
      },
    },
  },
}
