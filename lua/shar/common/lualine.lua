--[[
-- lualine: fancy statusline plugin.
--]]
local vim = vim
local packer = require 'packer'
packer.use {
  'nvim-lualine/lualine.nvim',
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
}

local function iminsert_language()
  if vim.api.nvim_buf_get_option(0, 'iminsert') == 0 then
    return 'en'
  end
  return 'ru'
end

require('lualine').setup {
  options = {
    theme = 'gruvbox',
  },
  sections = {
    lualine_b = { 'diagnostics' },
    lualine_x = { iminsert_language, 'encoding', 'filetype' },
    lualine_y = {},
  },
  inactive_sections = {
    lualine_x = {},
  },
}
