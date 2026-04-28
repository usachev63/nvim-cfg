return {
  'catppuccin/nvim',
  name = 'catppuccin',
  priority = 1000,
  config = function()
    local catppuccin = require 'catppuccin'
    catppuccin.setup {
      integrations = {
        diffview = true,
        leap = true,
        mason = true,
        cmp = true,
        notify = true,
        nvimtree = true,
      },
    }
    vim.cmd 'colorscheme catppuccin-frappe'
  end,
}

