local M = {}

function M.pack()
  local packer = require 'packer'
  packer.use {
    'kiyoon/jupynium.nvim',
    run = 'pip3 install --user .',
    requires = {
      'rcarriga/nvim-notify',
      'stevearc/dressing.nvim',
    },
  }
end

function M.setup()
  local jupynium = require 'jupynium'
  jupynium.setup {
    default_notebook_URL = "localhost:8888/tree"
  }
end

return M
