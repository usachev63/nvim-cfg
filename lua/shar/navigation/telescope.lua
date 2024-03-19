---telescope.nvim: fuzzy finder over lists (mainly files).

local M = {}

local vim = vim

---Set up telescope-related keymaps.
local function setup_keymaps()
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', '<leader>ff', function()
    builtin.find_files { path_display = { 'truncate' } }
  end, {})
  vim.keymap.set('n', '<leader>fi', function()
    builtin.find_files { no_ignore = true }
  end, {})
  vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
  vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
  vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})
  vim.keymap.set('n', '<leader>fr', builtin.resume, {})
  vim.keymap.set('n', '<leader>fd', function()
    builtin.lsp_dynamic_workspace_symbols {
      symbol_width = 60,
    }
  end, {})
end

function M.pack()
  require('packer').use {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope-fzy-native.nvim',
    },
  }
end

---Set up integration with telescope.nvim.
function M.setup()
  setup_keymaps()
  local telescope = require 'telescope'
  telescope.load_extension 'fzy_native'
  telescope.setup {
    defaults = {
      -- sorting_strategy = 'ascending',
      -- selection_strategy = 'closest',
      -- selection_caret = '  ',
      -- prompt_prefix = '  ',
      -- layout_strategy = 'center',
      layout_config = {},
    },
  }
end

return M
