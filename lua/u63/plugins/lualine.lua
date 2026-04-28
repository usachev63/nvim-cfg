return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  config = function()
    local lualine = require 'lualine'
    lualine.setup {
      options = {
        theme = 'catppuccin-frappe',
      },
      sections = {
        lualine_a = { 'filename', 'location' },
        lualine_b = { 'diagnostics' },
        lualine_c = {},
        lualine_x = { 'encoding' },
        lualine_y = {},
        lualine_z = { 'mode' },
      },
      inactive_sections = {
        lualine_a = { 'filename', 'location' },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
      },
    }
  end,
}
