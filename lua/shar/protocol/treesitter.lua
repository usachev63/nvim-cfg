---tree-sitter support.

local M = {}

---Setup tree-sitter support.
function M.pack()
  require('packer').use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      local ts_install = require 'nvim-treesitter.install'
      local ts_update = ts_install.update {
        with_sync = true,
      }
      ts_update()
    end,
  }
end

function M.init()
  require('nvim-treesitter.configs').setup {
    ensure_installed = { 'c', 'cpp', 'lua', 'vim', 'vimdoc', 'query' },
    auto_install = true,
    highlight = {
      enable = true,
      disable = { 'haskell' },
      additional_vim_regex_highlighting = true,
    },
  }
end

return M
