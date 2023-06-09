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
  mapping = {
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-y>'] = cmp.mapping.confirm(),
  },
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
