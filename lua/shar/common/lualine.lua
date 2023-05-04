--[[
-- lualine: fancy statusline plugin.
--]]
local packer = require 'packer'
packer.use 'nvim-lualine/lualine.nvim'
packer.use 'nvim-tree/nvim-web-devicons'

require('lualine').setup {
  options = {
    theme = 'gruvbox',
  },
  sections = {
    lualine_b = { 'diagnostics' },
    lualine_x = { 'encoding', 'filetype' },
    lualine_y = {},
  },
  inactive_sections = {
    lualine_x = {},
  },
}
