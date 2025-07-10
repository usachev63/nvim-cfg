---telescope.nvim: fuzzy finder over lists (mainly files).

local M = {}

---Set up telescope-related keymaps.
local function setup_keymaps()
  local builtin = require 'telescope.builtin'
  vim.keymap.set('n', ';zf', builtin.git_files, {})
  vim.keymap.set('n', ';za', function()
    builtin.find_files { no_ignore = true }
  end, {})
  vim.keymap.set('n', ';zg', builtin.live_grep, {})
  vim.keymap.set('n', ';zb', builtin.buffers, {})
  vim.keymap.set('n', ';zr', builtin.resume, {})
  vim.keymap.set('n', ';z"', builtin.registers, {})
  vim.keymap.set('n', ';zq', builtin.quickfix, {})
  vim.keymap.set('n', ';zm', builtin.marks, {})
end

function M.pack()
  require('packer').use {
    'nvim-telescope/telescope.nvim',
    branch = 'master',
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
      layout_strategy = 'vertical',
      layout_config = {},
      preview = false,
    },
  }
end

return M
