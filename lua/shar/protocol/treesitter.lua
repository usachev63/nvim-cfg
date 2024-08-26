---tree-sitter support.

local M = {}

---Setup tree-sitter support.
function M.pack()
  local packer = require 'packer'
  packer.use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_install = require 'nvim-treesitter.install'
      local ts_update = ts_install.update {
        with_sync = true,
      }
      ts_update()
    end,
  }
  packer.use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter',
  }
end

function M.init()
  vim.keymap.set('n', ']f', '<Nop>')
  vim.keymap.set('n', '[f', '<Nop>')
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query' },
    auto_install = true,
    highlight = {
      enable = true,
      disable = { 'haskell' },
      additional_vim_regex_highlighting = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
        },
        include_surrounding_whitespace = true,
        selection_modes = {
          ['@function.outer'] = 'V', -- linewise
        },
      },
      move = {
        enable = true,
        set_jumps = true,
        goto_next_start = {
          [']f'] = '@function.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
        },
      },
    },
  }
end

return M
