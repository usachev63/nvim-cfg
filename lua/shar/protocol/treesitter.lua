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

function M.init() end

return M
