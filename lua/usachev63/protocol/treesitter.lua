---tree-sitter support.

local M = {}

---Setup tree-sitter support.
function M.pack()
  local packer = require 'packer'
  packer.use {
    'nvim-treesitter/nvim-treesitter',
  }
  packer.use {
    'nvim-treesitter/nvim-treesitter-textobjects',
    after = 'nvim-treesitter',
    requires = 'nvim-treesitter/nvim-treesitter',
  }
  packer.use {
    requires = { 'nvim-treesitter/nvim-treesitter' },
    'Badhi/nvim-treesitter-cpp-tools',
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
      disable = { 'c', 'cpp', 'haskell' },
      additional_vim_regex_highlighting = true,
    },
    textobjects = {
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ['af'] = '@function.outer',
          ['if'] = '@function.inner',
          ['aa'] = '@parameter.outer',
          ['ia'] = '@parameter.inner',
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
          [']a'] = '@parameter.outer',
        },
        goto_next_end = {
          [']F'] = '@function.outer',
          [']A'] = '@parameter.outer',
        },
        goto_previous_start = {
          ['[f'] = '@function.outer',
          ['[a'] = '@parameter.outer',
        },
        goto_previous_end = {
          ['[F'] = '@function.outer',
          ['[A'] = '@parameter.outer',
        },
      },
      swap = {
        enable = true,
        swap_next = {
          ['<Leader>wa'] = '@parameter.inner',
        },
        swap_previous = {
          ['<Leader>wA'] = '@parameter.inner',
        },
      },
    },
  }
  require('nt-cpp-tools').setup {
    preview = {
      quit = '<esc>', -- optional keymapping for quit preview
      accept = 'p', -- optional keymapping for accept preview
    },
  }
end

return M
