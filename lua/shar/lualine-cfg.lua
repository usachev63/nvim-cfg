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
