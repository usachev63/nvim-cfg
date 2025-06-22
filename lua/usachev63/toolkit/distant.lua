local M = {}

function M.pack()
  require('packer').use {
    'chipsenkbeil/distant.nvim',
    branch = 'v0.3',
  }
end

function M.setup()
  require('distant'):setup()
end

return M
