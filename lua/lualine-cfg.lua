require('lualine').setup {
  options = {
    theme = 'gruvbox',
  },
  sections = {
    lualine_b = { 'diff', 'diagnostics' },
  },
  inactive_sections = {
    lualine_x = {},
  },
}
